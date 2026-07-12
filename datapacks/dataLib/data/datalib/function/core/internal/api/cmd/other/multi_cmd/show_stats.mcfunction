# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/internal/show_stats
# Show statistics
# ─────────────────────────────────────────────────────────────────

execute store result score $mcmd_end_time dl.tmp run time query gametime
execute store result score $mcmd_duration dl.tmp run data get storage datalib:engine _mcmd_stats.start_time
scoreboard players operation $mcmd_duration dl.tmp = $mcmd_end_time dl.tmp
scoreboard players operation $mcmd_duration dl.tmp -= $mcmd_duration dl.tmp

execute store result storage datalib:engine _mcmd_stats.total int 1 run scoreboard players get $mcmd_total dl.tmp
execute store result storage datalib:engine _mcmd_stats.success int 1 run scoreboard players get $mcmd_success dl.tmp
execute store result storage datalib:engine _mcmd_stats.duration int 1 run scoreboard players get $mcmd_duration dl.tmp

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/stats ","color":"aqua"},{"text":"Total: ","color":"#555555"},{"nbt":"_mcmd_stats.total","storage":"datalib:engine","color":"white"},{"text":" | Success: ","color":"#555555"},{"nbt":"_mcmd_stats.success","storage":"datalib:engine","color":"green"},{"text":" | Duration: ","color":"#555555"},{"nbt":"_mcmd_stats.duration","storage":"datalib:engine","color":"yellow"},{"text":"t","color":"yellow"}]

scoreboard players reset $mcmd_total dl.tmp
scoreboard players reset $mcmd_success dl.tmp
scoreboard players reset $mcmd_duration dl.tmp
scoreboard players reset $mcmd_end_time dl.tmp
data remove storage datalib:engine _mcmd_stats
