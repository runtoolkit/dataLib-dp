execute unless function datalib:debug/tools/utils/check_all run return 0

$title @a[name=$(player),limit=1] title {"text":"$(title)","color":"$(color)","bold":true}
$title @a[name=$(player),limit=1] subtitle {"text":"$(subtitle)","color":"$(sub_color)","italic":true}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/title_sub ","color":"aqua"},{"text":"$(player)","color":"white"}]
