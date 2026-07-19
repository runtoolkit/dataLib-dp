execute unless function datalib:debug/tools/utils/check_all run return 0

$execute as @a[name=$(player),limit=1] at @s run scoreboard players set @s $(objective) $(value)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/scoreboard_set ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(value)","color":"aqua"}]
