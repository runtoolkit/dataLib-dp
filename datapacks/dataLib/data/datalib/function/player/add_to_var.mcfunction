$execute store result score $pvar dl.tmp run data get storage datalib:engine players.$(player).$(key)
$scoreboard players set $pamount dl.tmp $(amount)
scoreboard players operation $pvar dl.tmp += $pamount dl.tmp
$execute store result storage datalib:engine players.$(player).$(key) int 1 run scoreboard players get $pvar dl.tmp
execute store result storage datalib:output result int 1 run scoreboard players get $pvar dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/add_to_var ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]