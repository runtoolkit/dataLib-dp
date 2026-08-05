scoreboard players set $pex_pid dl.tmp 0
$execute store result score $pex_pid dl.tmp run data get storage datalib:engine player_pids.$(player)
execute if score $pex_pid dl.tmp matches 0 run return 0

data modify storage datalib:engine _pex_tmp set value {result:0b}
execute as @a if score @s datalib.pid = $pex_pid dl.tmp run execute if entity @s[tag=datalib.admin] run data modify storage datalib:engine _pex_tmp.result set value 1b
$execute if data storage datalib:engine permissions.$(player).$(perm) run data modify storage datalib:engine _pex_tmp.result set value 1b

$execute if data storage datalib:engine _pex_tmp{result:0b} run execute as @a if score @s datalib.pid = $pex_pid dl.tmp run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"$(perm)","color":"yellow"},{"text":" — you don't have this permission.","color":"red"}]
execute if data storage datalib:engine _pex_tmp{result:0b} run return 0

$execute as @a if score @s datalib.pid = $pex_pid dl.tmp at @s run $(cmd)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm/exec ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" [","color":"#555555"},{"text":"$(perm)","color":"aqua"},{"text":"] → ","color":"#555555"},{"text":"$(cmd)","color":"green"}]
data remove storage datalib:engine _pex_tmp
