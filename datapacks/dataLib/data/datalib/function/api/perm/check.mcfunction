scoreboard players set $pc_pid dl.tmp 0
$execute store result score $pc_pid dl.tmp run data get storage datalib:engine player_pids.$(player)
execute if score $pc_pid dl.tmp matches 0 run return 0

execute as @a if score @s datalib.pid = $pc_pid dl.tmp run execute if entity @s[tag=datalib.admin] run return 1

$execute as @a if score @s datalib.pid = $pc_pid dl.tmp run execute if entity @s[tag=perm.$(perm)] run return 1

execute as @a if score @s datalib.pid = $pc_pid dl.tmp run playsound datalib:perm.denied master @s ~ ~ ~ 1 1
$execute as @a if score @s datalib.pid = $pc_pid dl.tmp run tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"text":"✘ ","color":"red"},{"text":"$(perm)","color":"yellow"},{"text":" ","color":"red"},{"translate":"datalib.msg.no_perm","with":[""],"color":"red"}]
return 0
