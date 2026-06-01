# datalib:core/security/type_violation  [1_20_5 OVERLAY]
data modify storage datalib:engine _log_add_tmp.message set value "[Security] type_violation — sandbox command not in allowlist"
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine {}
data remove storage datalib:engine _log_add_tmp.message
data remove storage datalib:engine _log_add_tmp.level
data remove storage datalib:engine _log_add_tmp.color

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Security violation: command not permitted in sandbox mode.","color":"red"}]
function datalib:core/security/type_violation/notify_admins with storage datalib:engine {}
execute if entity @s[type=minecraft:player] run kick @s [DL] Security violation — sandbox command blocked
