# datalib:core/fallback/no_permission  [1_20_5 OVERLAY]
# Called when executor's dl.perm_level < required threshold.
data modify storage datalib:engine _log_add_tmp.message set value "[Fallback] no_permission — dl.perm_level below required threshold"
data modify storage datalib:engine _log_add_tmp.level set value "WARN"
data modify storage datalib:engine _log_add_tmp.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine {}
data remove storage datalib:engine _log_add_tmp.message
data remove storage datalib:engine _log_add_tmp.level
data remove storage datalib:engine _log_add_tmp.color

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied. Your ","color":"red"},{"text":"dl.perm_level","color":"aqua"},{"text":" is insufficient.","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"NO_PERM ","color":"yellow","bold":true},{"selector":"@s","color":"gold"},{"text":" — perm_level below threshold","color":"yellow"}]

data modify storage datalib:output fallback set value {triggered:1b,reason:"no_permission"}
return 0
