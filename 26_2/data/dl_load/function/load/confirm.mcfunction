# dl_load:load/confirm
# DL Load Confirmation Gate — Stage 0 dispatcher
# Execution context: minecraft:marker (spawned by dl_load:_)
#
# PURPOSE
# -------
# The minecraft:load tag fires on /reload AND on server/world open.
# If datalib:engine storage already holds live data from a previous session
# (permission maps, flag tables, wand binds, etc.), overwriting it
# immediately causes nondeterministic state and silent data loss.
#
# This function sets a scoreboard-based pending flag, broadcasts the
# confirmation instructions to the server log via marker say (immune to
# the server-startup tellraw / clickEvent rendering bug), and schedules
# an automatic cancel after 5 minutes.
#
# NOTHING in datalib:engine storage is touched here.
# Storage writes happen only after dl_load:load/yes is called.
#
# FLOW
# ----
#   dl_load:_ (stage0)
#     └─ dl_load:load/confirm   ← this file (runs as marker)
#         ├─ broadcasts instructions
#         └─ schedules dl_load:timeout (5m)
#
#   Admin: /function dl_load:load/yes
#     └─ dl_load:load/all → full init pipeline
#
#   Admin: /function dl_load:load/no
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

# Broadcast via marker say — works at server start, no clickEvent, no players required
say [DL GATE] ========================================
say [DL GATE] dataLib load is PENDING.
say [DL GATE] Storage has NOT been modified yet.
say [DL GATE] ----------------------------------------
say [DL GATE] CONFIRM:  /function dl_load:load/yes
say [DL GATE] CANCEL:   /function dl_load:load/no
say [DL GATE] ----------------------------------------
say [DL GATE] Auto-cancel fires in 5 minutes if no response.
say [DL GATE] ========================================

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
execute if data storage datalib:engine {sandbox:1b} run say [DL GATE] SANDBOX MODE — auto-confirming load.
execute if data storage datalib:engine {sandbox:1b} run function dl_load:load/yes
execute if data storage datalib:engine {sandbox:1b} run return 0
