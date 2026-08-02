# datalib:runtime/load/loader/load/confirm
# DL Load Confirmation Gate — Stage 0 dispatcher
# Execution context: whichever entity/console called datalib:runtime/load/loader/main
# (no marker entity is spawned anymore — see datalib:runtime/load/loader/main header)
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
# Storage writes happen only after datalib:runtime/load/loader/load/yes is called.
#
# FLOW
# ----
#   datalib:runtime/load/loader/main (stage0)
#     └─ datalib:runtime/load/loader/load/confirm   ← this file
#         ├─ broadcasts clickable prompt
#         └─ schedules datalib:runtime/load/loader/timeout (5m)
#
#   Admin: /function datalib:runtime/load/loader/load/yes  (or clicks [Confirm])
#     └─ datalib:runtime/load/loader/load/all → full init pipeline
#
#   Admin: /function datalib:runtime/load/loader/load/no  (or clicks [Cancel])
#     └─ abort — storage untouched
#
#   5 minutes elapse with no response:
#     └─ datalib:runtime/load/loader/timeout → datalib:runtime/load/loader/load/no (auto-abort)

# Create load-gate tracking objective
# Safe to call even if objective already exists (add is idempotent)
scoreboard objectives add dl.load dummy

# Ensure load config defaults exist (idempotent, only fills missing keys)
function datalib:api/config/load_cfg

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
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"[Confirm]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function datalib:runtime/load/loader/load/yes"}},{"text":"   ","color":"gray"},{"text":"[Cancel]","color":"red","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function datalib:runtime/load/loader/load/no"}}]
tellraw @a ["",{"text":"[DL GATE] ----------------------------------------","color":"#555555"}]

tellraw @a ["",{"text":"[DL GATE] ========================================","color":"#555555"}]

# Schedule auto-cancel using the config value.
# NOTE: /schedule cannot take a macro argument for its duration — this is
# a confirmed Minecraft engine limitation (macros are not supported by
# /schedule as of this version). So instead of a truly dynamic duration,
# we branch over a fixed set of allowed values from datalib:api/config/load_cfg.
# Anything outside this set falls back to the 300s default.
# 'replace' ensures repeated /reload does not stack multiple timeout schedules
scoreboard players set #timeout_matched dl.tmp 0
scoreboard players set #timeout_actual dl.tmp 300
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 60 run scoreboard players set #timeout_matched dl.tmp 1
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 60 run scoreboard players set #timeout_actual dl.tmp 60
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 60 run schedule function datalib:runtime/load/loader/timeout 60s replace
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 120 run scoreboard players set #timeout_matched dl.tmp 1
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 120 run scoreboard players set #timeout_actual dl.tmp 120
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 120 run schedule function datalib:runtime/load/loader/timeout 120s replace
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 180 run scoreboard players set #timeout_matched dl.tmp 1
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 180 run scoreboard players set #timeout_actual dl.tmp 180
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 180 run schedule function datalib:runtime/load/loader/timeout 180s replace
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 300 run scoreboard players set #timeout_matched dl.tmp 1
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 300 run schedule function datalib:runtime/load/loader/timeout 300s replace
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 600 run scoreboard players set #timeout_matched dl.tmp 1
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 600 run scoreboard players set #timeout_actual dl.tmp 600
execute if score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 600 run schedule function datalib:runtime/load/loader/timeout 600s replace
# Fallback: value wasn't one of the allowed presets (whether in-range or not) — #timeout_actual stays 300
execute if score #timeout_matched dl.tmp matches 0 run schedule function datalib:runtime/load/loader/timeout 300s replace

# Announce the ACTUAL scheduled duration (#timeout_actual), not the raw
# config value, so the message can never disagree with what was scheduled.
# NOTE: a $-prefixed macro line cannot be nested inside 'execute ... run' —
# it must be a standalone top-level line. We store a suffix flag instead
# and always emit the same macro tellraw line.
data modify storage datalib:engine _timeout_tmp.suffix set value "(s)"
execute if score #timeout_matched dl.tmp matches 0 run data modify storage datalib:engine _timeout_tmp.suffix set value " (invalid config value, using default)"
execute store result storage datalib:engine _timeout_tmp.seconds int 1 run scoreboard players get #timeout_actual dl.tmp
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Auto-cancel fires in","color":"gray"}," ",{"nbt":"_timeout_tmp.seconds","storage":"datalib:engine","plain":true}," ",{"text":"if no response","color":"gray"},"",{"storage":"datalib:engine","nbt":"_timeout_tmp.suffix","color":"gray","plain":false,"interpret":true},{"text":".","color":"gray"}]
# ─────────────────────────────────────────────────────────────────
# SANDBOX MODE — auto-confirm
# Enable (legacy):  /data modify storage datalib:engine sandbox set value 1b
# Enable (config):  /scoreboard players set #runtoolkit.packs.datalib.config.load.sandbox_enabled datalib.meta 1
# Disable:          set either back to 0 / 0b
# Both are checked — either one enables sandbox mode.
# Storage/scoreboard values persist across reloads — set once, active until cleared.
# NOTE: schedule is cleared inside load/yes. Do NOT remove dl.load
#       objective here — load/yes guard checks #pending dl.load == 1.
# ─────────────────────────────────────────────────────────────────
scoreboard players set #sandbox_active dl.tmp 0
execute if data storage datalib:engine {sandbox:1b} run scoreboard players set #sandbox_active dl.tmp 1
execute if score #runtoolkit.packs.datalib.config.load.sandbox_enabled datalib.meta matches 1 run scoreboard players set #sandbox_active dl.tmp 1
execute if score #sandbox_active dl.tmp matches 1 run tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"SANDBOX MODE — auto-confirming load.","color":"yellow"}]
execute if score #sandbox_active dl.tmp matches 1 run function datalib:runtime/load/loader/load/yes
execute if score #sandbox_active dl.tmp matches 1 run return 0
