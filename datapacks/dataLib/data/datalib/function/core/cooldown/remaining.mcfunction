data modify storage datalib:output result set value 0
$execute unless data storage datalib:engine cooldowns.$(player).$(key) run return 0

$execute store result score $cd_exp dl.tmp run data get storage datalib:engine cooldowns.$(player).$(key)
execute store result score $cd_now dl.tmp run scoreboard players get $epoch datalib.time

scoreboard players operation $cd_exp dl.tmp -= $cd_now dl.tmp
execute if score $cd_exp dl.tmp matches 1.. run execute store result storage datalib:output result int 1 run scoreboard players get $cd_exp dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/remaining ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
