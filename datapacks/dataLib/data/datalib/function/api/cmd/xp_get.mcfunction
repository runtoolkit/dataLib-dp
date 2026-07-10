execute unless function datalib:debug/tools/utils/check_all run return 0

$execute store result storage datalib:output result int 1 run xp query @a[name=$(player),limit=1] $(type)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/xp_get ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
