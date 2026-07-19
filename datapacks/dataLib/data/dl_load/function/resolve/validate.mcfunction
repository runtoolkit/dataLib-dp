# dl_load:resolve/validate
# Returns 1 → validation passed, load continues.
# Returns 0 → validation failed, load aborted.
#
# v6.0.1-pre2: split out of the old monolithic
# core/internal/load/validate.mcfunction into dl_load:resolve/* —
# version compatibility and dependency resolution are distinct
# concerns and are now separately testable/callable:
#   dl_load:resolve/version       — stale-scoreboard version match
#   dl_load:resolve/dependencies  — rt_origin/fork + StringLib

# ── Init storage if fresh ────────────────────────────────────────
execute unless data storage datalib:engine global run data modify storage datalib:engine global set value {version:"v6.0.1-pre2"}
data modify storage datalib:engine global.version set value "v6.0.1-pre2"

execute unless data storage datalib:engine log_display run data modify storage datalib:engine log_display set value []
execute unless score #dl.log_count dl.tmp matches 0.. run scoreboard players set #dl.log_count dl.tmp 0

# ── Guard: already loaded ────────────────────────────────────────
execute if data storage datalib:engine global{loaded:1b} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"Already loaded — skipping reload.","color":"yellow"}]
execute if data storage datalib:engine global{loaded:1b} run return 0

# ── Version resolution ───────────────────────────────────────────
execute unless function dl_load:resolve/version run return 0

# ── Dependency resolution (fork/origin + StringLib) ──────────────
function dl_load:resolve/dependencies

return 1
