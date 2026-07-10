execute unless function datalib:debug/tools/utils/check_all run return 0

$bossbar set $(id) max $(max)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/bossbar_set_max ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(id)","color":"aqua"}]
