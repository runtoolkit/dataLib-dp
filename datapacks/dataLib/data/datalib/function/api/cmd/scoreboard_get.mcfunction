execute unless function datalib:debug/tools/utils/check_all run return 0

$execute store result storage datalib:output result int 1 run scoreboard players get @a[name=$(player),limit=1] $(objective)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/scoreboard_get ","color":"aqua"},{"text":"$(player)","color":"white"}]
