# datalib:api/cmd/internal/sandbox_blocked_macro [MACRO]
# INPUT: $(_sandbox_cmd) — read from datalib:engine storage via `with storage datalib:engine {}`
# Logs WARN entry, notifies debug admins, and kicks the player.
# Do NOT call directly — use datalib:api/cmd/internal/sandbox_blocked.
$data modify storage datalib:engine _log_add_tmp.message set value "[SANDBOX] cmd/$(_sandbox_cmd) blocked"
data modify storage datalib:engine _log_add_tmp.level set value "WARN"
data modify storage datalib:engine _log_add_tmp.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine _log_add_tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"SANDBOX ","color":"red","bold":true},{"text":"cmd/$(_sandbox_cmd) blocked","color":"red"}]
data remove storage datalib:engine _log_add_tmp.message
data remove storage datalib:engine _log_add_tmp.level
data remove storage datalib:engine _log_add_tmp.color
execute if entity @s[type=player] run playsound datalib:ui.error master @s ~ ~ ~ 0.7 0.8
execute if entity @s[type=player] run tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"text":"✘ ","color":"red"},{"translate":"datalib.msg.sandbox_blocked","color":"red"}]
