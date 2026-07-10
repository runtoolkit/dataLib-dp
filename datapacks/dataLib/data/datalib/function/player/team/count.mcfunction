scoreboard players set $team_cnt dl.tmp 0
$execute as @a[team=$(team)] run scoreboard players add $team_cnt dl.tmp 1
execute store result storage datalib:output result int 1 run scoreboard players get $team_cnt dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"team/count ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
