data modify storage datalib:output result set value 1b

$execute unless data storage datalib:engine cooldowns.$(player).$(key) run return 0

$execute store result score $cd_exp dl.tmp run data get storage datalib:engine cooldowns.$(player).$(key)
execute store result score $cd_now dl.tmp run scoreboard players get $epoch datalib.time

execute if score $cd_now dl.tmp < $cd_exp dl.tmp run data modify storage datalib:output result set value 0b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/check ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
