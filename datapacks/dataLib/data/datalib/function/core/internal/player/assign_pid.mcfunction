execute store result score $next_pid dl.tmp run data get storage datalib:engine _pid_seq

scoreboard players add $next_pid dl.tmp 1

$execute store result storage datalib:engine player_pids.$(player) int 1 run scoreboard players get $next_pid dl.tmp
$scoreboard players operation @a[name=$(player),limit=1] datalib.pid = $next_pid dl.tmp

execute store result storage datalib:engine _pid_seq int 1 run scoreboard players get $next_pid dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/internal/assign_pid ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → pid=","color":"#555555"},{"score":{"name":"$next_pid","objective":"dl.tmp"},"color":"green"}]
