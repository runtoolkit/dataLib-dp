$execute store result score $cv dl.tmp run data get storage datalib:engine players.$(player).$(key)
$scoreboard players set $cv_mn dl.tmp $(min)
$scoreboard players set $cv_mx dl.tmp $(max)
execute if score $cv dl.tmp < $cv_mn dl.tmp run scoreboard players operation $cv dl.tmp = $cv_mn dl.tmp
execute if score $cv dl.tmp > $cv_mx dl.tmp run scoreboard players operation $cv dl.tmp = $cv_mx dl.tmp
$execute store result storage datalib:engine players.$(player).$(key) int 1 run scoreboard players get $cv dl.tmp
execute store result storage datalib:output result int 1 run scoreboard players get $cv dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/clamp_var ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]