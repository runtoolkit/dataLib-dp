execute unless function datalib:debug/tools/utils/check_all run return 0

$scoreboard players set $(player) $(objective) $(value)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/trigger_set ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(value)","color":"aqua"}]
