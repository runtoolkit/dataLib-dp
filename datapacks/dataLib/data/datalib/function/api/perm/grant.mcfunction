execute if entity @s unless entity @s[tag=datalib.admin] run playsound datalib:perm.denied master @s ~ ~ ~ 1 1
execute if entity @s unless entity @s[tag=datalib.admin] run return run tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"text":"✘ ","color":"red"},{"translate":"datalib.msg.permission_denied","color":"red"}]

$data modify storage datalib:engine permissions.$(player).$(perm) set value 1b

scoreboard players set $pg_pid dl.tmp 0
$execute store result score $pg_pid dl.tmp run data get storage datalib:engine player_pids.$(player)
$execute as @a if score @s datalib.pid = $pg_pid dl.tmp run tag @s add perm.$(perm)
$advancement grant @a[name=$(player),limit=1] only datalib:api/perm/$(perm)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm/grant ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(player)","color":"white"},{"text":" ← ","color":"#555555"},{"text":"$(perm)","color":"aqua"}]
