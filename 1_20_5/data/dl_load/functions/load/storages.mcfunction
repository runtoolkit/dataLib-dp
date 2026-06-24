execute unless score $epoch datalib.time matches -2147483648..2147483647 run scoreboard players set $epoch datalib.time 0
scoreboard players set $tick dl.tmp 0

scoreboard players set $pq_depth dl.tmp 0

scoreboard players set $pb_four dl.tmp 1

execute unless data storage datalib:engine throttle run data modify storage datalib:engine throttle set value {}

execute unless data storage datalib:engine flags run data modify storage datalib:engine flags set value {}
execute unless data storage datalib:engine states run data modify storage datalib:engine states set value {}

execute unless data storage datalib:engine permissions run data modify storage datalib:engine permissions set value {}

execute unless data storage datalib:engine perm_triggers run data modify storage datalib:engine perm_triggers set value {}
execute unless data storage datalib:engine perm_trigger_names run data modify storage datalib:engine perm_trigger_names set value []

execute unless data storage datalib:engine trigger_binds run data modify storage datalib:engine trigger_binds set value []

execute unless data storage datalib:engine interaction_binds run data modify storage datalib:engine interaction_binds set value {attack:[], use:[]}

execute unless data storage datalib:engine player_pids run data modify storage datalib:engine player_pids set value {}
execute unless data storage datalib:engine _pid_seq run data modify storage datalib:engine _pid_seq set value 0

# UUID module init
function datalib:core/internal/systems/uuid/init

# once_per_player module init
execute unless data storage datalib:engine once_per_player run data modify storage datalib:engine once_per_player set value {}

# Wand module init
execute unless data storage datalib:engine wand_binds run data modify storage datalib:engine wand_binds set value []

# Hook module init
execute unless data storage datalib:engine hook_binds run data modify storage datalib:engine hook_binds set value []

# lib/fiber module init
execute unless data storage datalib:engine fibers run data modify storage datalib:engine fibers set value {}
data remove storage datalib:engine fibers._pending

# geo/region_watch module init
# Watches are cleared on reload — must re-register on each load
data remove storage datalib:engine region_watches
data modify storage datalib:engine region_watches set value []

# lib/batch module init
# Incomplete batches are cleared on reload
data remove storage datalib:engine batches
data modify storage datalib:engine batches set value {}

# ─────────────────────────────────────────────────────────────────
# Security module v6.0.0+ additions
# BREAKING CHANGE: sandbox_allowlist is now a compound {} (was list []).
# Empty compound {} = all sandbox commands blocked.
# multi_type_allowlist: compound of permitted multiCommands.type values.
# multiCommands: tracks active multi-command execution context.
# ─────────────────────────────────────────────────────────────────
execute if data storage datalib:engine security.sandbox_allowlist[] run data modify storage datalib:engine security.sandbox_allowlist set value {}
execute unless data storage datalib:engine security run data modify storage datalib:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:{}}
execute unless data storage datalib:engine security.sandbox_allowlist run data modify storage datalib:engine security.sandbox_allowlist set value {}
execute unless data storage datalib:engine security.multi_type_allowlist run data modify storage datalib:engine security.multi_type_allowlist set value {multi_cmd:1b,multi_cmd_adv:1b}

data remove storage datalib:engine multiCommands
data modify storage datalib:engine multiCommands set value {type:"",active:0b}

# Wand cooldown module — separate storage
execute unless data storage datalib:engine wand_cooldowns run data modify storage datalib:engine wand_cooldowns set value {}

# Security v6.0.0+ migration: sandbox_allowlist list → compound
execute if data storage datalib:engine security.sandbox_allowlist[] run data modify storage datalib:engine security.sandbox_allowlist set value {}
execute unless data storage datalib:engine security.sandbox_allowlist run data modify storage datalib:engine security.sandbox_allowlist set value {}
execute unless data storage datalib:engine security.multi_type_allowlist run data modify storage datalib:engine security.multi_type_allowlist set value {multi_cmd:1b,multi_cmd_adv:1b}

# Module toggle init
execute unless data storage datalib:engine modules.hook run data modify storage datalib:engine modules.hook set value 1b
execute unless data storage datalib:engine modules.interaction run data modify storage datalib:engine modules.interaction set value 1b
execute unless data storage datalib:engine modules.perm run data modify storage datalib:engine modules.perm set value 1b
execute unless data storage datalib:engine modules.wand run data modify storage datalib:engine modules.wand set value 1b
execute unless data storage datalib:engine modules.geo run data modify storage datalib:engine modules.geo set value 1b
