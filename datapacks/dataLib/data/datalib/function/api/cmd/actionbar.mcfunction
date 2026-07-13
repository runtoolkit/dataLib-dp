execute unless function datalib:debug/tools/utils/check_all run return 0

$execute as @a[name=$(player),limit=1] at @s run title @s actionbar {"text":"$(text)","color":"$(color)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/actionbar ","color":"aqua"},{"text":"$(player)","color":"white"}]
