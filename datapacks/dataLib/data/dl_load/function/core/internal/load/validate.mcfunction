# dl_load:load/internal/validate
# Returns 1 → validation passed, load continues.
# Returns 0 → validation failed, load aborted.

# ── Init storage if fresh ────────────────────────────────────────
execute unless data storage datalib:engine global run data modify storage datalib:engine global set value {version:"v6.0.1-pre1"}
data modify storage datalib:engine global.version set value "v6.0.1-pre1"

execute unless data storage datalib:engine log_display run data modify storage datalib:engine log_display set value []
execute unless score #dl.log_count dl.tmp matches 0.. run scoreboard players set #dl.log_count dl.tmp 0

# ── Guard: already loaded ────────────────────────────────────────
execute if data storage datalib:engine global{loaded:1b} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"Already loaded — skipping reload.","color":"yellow"}]
execute if data storage datalib:engine global{loaded:1b} run return 0

# ── Version check ────────────────────────────────────────────────
scoreboard objectives add dl.pre_version dummy
scoreboard players set #dl.mismatch dl.pre_version 0
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.major dl.pre_version matches 6 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.minor dl.pre_version matches 0 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.patch dl.pre_version matches 1 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute if score #dl.pre dl.pre_version matches 1.. run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.mismatch dl.pre_version matches 1 run function dl_load:core/internal/load/version_warn
execute if score #dl.mismatch dl.pre_version matches 1 run return 0

# ── Fork detection ───────────────────────────────────────────────
# _rt_origin.mcfunction sets rt_origin_verified:1b at load time.
# Must run BEFORE the check below, otherwise the flag is never set yet
# on this pass (all.mcfunction calls _rt_origin AFTER validate) and the
# fork warning fires on every single load.
function datalib:_rt_origin
# Absence = file removed or pack is a modified fork.
# WARN only — load is not aborted, but admins are notified.
execute unless data storage datalib:engine global{rt_origin_verified:1b} run function dl_load:core/internal/load/fork_warn

# ── StringLib dependency ─────────────────────────────────────────
execute unless score #StringLib.Init StringLib matches 1 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"StringLib not initialized — datalib:core/lib/string/* unavailable","color":"yellow"}]

return 1
