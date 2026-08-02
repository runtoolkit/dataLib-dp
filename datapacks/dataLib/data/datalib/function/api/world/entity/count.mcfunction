scoreboard players set $ent_count dl.tmp 0
$execute as @e[type=$(type),tag=$(tag)] run scoreboard players add $ent_count dl.tmp 1
execute store result storage datalib:output count int 1 run scoreboard players get $ent_count dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/count ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
