# datalib:core/internal/api/cmd/sandbox_blocked_macro [MACRO] [1.20.5 overlay]
# INPUT: $(_sandbox_cmd) — read from datalib:engine storage.
# Logs WARN entry, notifies debug admins, and kicks the player.
$data modify storage datalib:engine _log_add_tmp.message set value "[SANDBOX] cmd/$(_sandbox_cmd) blocked"
data modify storage datalib:engine _log_add_tmp.level set value "WARN"
data modify storage datalib:engine _log_add_tmp.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine {}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"SANDBOX ","color":"red","bold":true},{"text":"cmd/$(_sandbox_cmd) blocked","color":"red"}]
data remove storage datalib:engine _log_add_tmp.message
data remove storage datalib:engine _log_add_tmp.level
data remove storage datalib:engine _log_add_tmp.color
execute if entity @s[type=minecraft:player] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Command blocked in sandbox mode.","color":"red"}]
#execute if entity @s[type=minecraft:player] run kick @s [DL] Sandbox violation — command blocked
