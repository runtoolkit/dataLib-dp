execute unless function datalib:debug/tools/utils/check_all run return 0

$ride @a[name=$(player),limit=1] mount $(vehicle)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/ride ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(vehicle)","color":"aqua"}]
