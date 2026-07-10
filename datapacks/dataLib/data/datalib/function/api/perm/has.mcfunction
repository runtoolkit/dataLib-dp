data modify storage datalib:output result set value 0b

scoreboard players set $ph_pid dl.tmp 0
$execute store result score $ph_pid dl.tmp run data get storage datalib:engine player_pids.$(player)

execute as @a if score @s datalib.pid = $ph_pid dl.tmp run execute if entity @s[tag=datalib.admin] run data modify storage datalib:output result set value 1b
$execute as @a if score @s datalib.pid = $ph_pid dl.tmp run execute if entity @s[tag=perm.$(perm)] run data modify storage datalib:output result set value 1b

$execute if data storage datalib:engine permissions.$(player).$(perm) run data modify storage datalib:output result set value 1b

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm/has ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(perm)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
