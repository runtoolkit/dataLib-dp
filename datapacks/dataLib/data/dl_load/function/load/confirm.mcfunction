# dl_load:load/confirm
# DL Load Confirmation Gate — Stage 0 dispatcher
# Execution context: whichever entity/console called dl_load:main
# (no marker entity is spawned anymore — see dl_load:main header)
#
# PURPOSE
# -------
# The minecraft:load tag fires on /reload AND on server/world open.
# If datalib:engine storage already holds live data from a previous session
# (permission maps, flag tables, wand binds, etc.), overwriting it
# immediately causes nondeterministic state and silent data loss.
#
# This function sets a scoreboard-based pending flag, broadcasts a
# clickable confirmation prompt via tellraw, and schedules an automatic
# cancel after 5 minutes.
#
# NOTHING in datalib:engine storage is touched here.
# Storage writes happen only after dl_load:load/yes is called.
#
# FLOW
# ----
#   dl_load:main (stage0)
#     └─ dl_load:load/confirm   ← this file
#         ├─ broadcasts clickable prompt
#         └─ schedules dl_load:timeout (5m)
#
#   Admin: /function dl_load:load/yes  (or clicks [Confirm])
#     └─ dl_load:load/all → full init pipeline
#
#   Admin: /function dl_load:load/no  (or clicks [Cancel])
#     └─ abort — storage untouched
#
#   5 minutes elapse with no response:
#     └─ dl_load:timeout → dl_load:load/no (auto-abort)

# Create load-gate tracking objective
# Safe to call even if objective already exists (add is idempotent)
scoreboard objectives add dl.load dummy

# Reset any stale state from a previous incomplete gate cycle
scoreboard players set #pending dl.load 0
scoreboard players set #confirmed dl.load 0
scoreboard players set #cancelled dl.load 0

# Open the gate window
scoreboard players set #pending dl.load 1

# Broadcast via tellraw — clickable buttons, no marker entity needed.
tellraw @a ["",{"text":"[DL GATE] ========================================","color":"#555555"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"dataLib load is PENDING.","color":"yellow","bold":true}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Storage has NOT been modified yet.","color":"gray"}]
tellraw @a ["",{"text":"[DL GATE] ----------------------------------------","color":"#555555"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"[Confirm]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:load/yes"}},{"text":"   ","color":"gray"},{"text":"[Cancel]","color":"red","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:load/no"}}]
tellraw @a ["",{"text":"[DL GATE] ----------------------------------------","color":"#555555"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Auto-cancel fires in 5 minutes if no response.","color":"gray"}]
tellraw @a ["",{"text":"[DL GATE] ========================================","color":"#555555"}]

# Schedule 5-minute auto-cancel
# 'replace' ensures repeated /reload does not stack multiple timeout schedules
schedule function dl_load:timeout 300s replace
# ─────────────────────────────────────────────────────────────────
# SANDBOX MODE — auto-confirm
# Enable:  /data modify storage datalib:engine sandbox set value 1b
# Disable: /data modify storage datalib:engine sandbox set value 0b
# Storage persists across reloads — set once, active until cleared.
# NOTE: schedule is cleared inside load/yes. Do NOT remove dl.load
#       objective here — load/yes guard checks #pending dl.load == 1.
# ─────────────────────────────────────────────────────────────────
execute if data storage datalib:engine {sandbox:1b} run tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"SANDBOX MODE — auto-confirming load.","color":"yellow"}]
execute if data storage datalib:engine {sandbox:1b} run function dl_load:load/yes
execute if data storage datalib:engine {sandbox:1b} run return 0
