# Score checker
execute store result score $mcmd_cond_score dl.tmp run scoreboard players get @s dummy
data modify storage datalib:engine _mcmd_cond_tmp set from storage datalib:engine _mcmd_current.condition.score
function datalib:core/internal/api/cmd/other/multi_cmd/cond_score_exec with storage datalib:engine _mcmd_cond_tmp
data remove storage datalib:engine _mcmd_cond_tmp
scoreboard players reset $mcmd_cond_score dl.tmp
