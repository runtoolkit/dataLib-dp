$scoreboard players set $cd_dur dl.tmp $(duration)
execute store result score $cd_now dl.tmp run scoreboard players get $epoch datalib.time
scoreboard players operation $cd_now dl.tmp += $cd_dur dl.tmp
$execute store result storage datalib:engine cooldowns.$(player).$(key) int 1 run scoreboard players get $cd_now dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/set ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" for ","color":"#555555"},{"text":"$(duration)","color":"green"},{"text":"t","color":"#555555"}]
