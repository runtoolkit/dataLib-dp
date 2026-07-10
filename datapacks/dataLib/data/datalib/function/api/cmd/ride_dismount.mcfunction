execute unless function datalib:debug/tools/utils/check_all run return 0

$ride @a[name=$(player),limit=1] dismount
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/ride_dismount ","color":"aqua"},{"text":"$(player)","color":"white"}]
