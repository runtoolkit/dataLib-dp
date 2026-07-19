execute unless function datalib:debug/tools/utils/check_all run return 0

# DL - Universal World Clock Controller
# Usage: /function ame:clock_handler {clock:"datalib:test", action:"set", value:"12000"}
$time of $(clock) $(action) $(value)

# System Debug Log for staff (Only for users with 'datalib.debug' tag)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"clock/system_update ","color":"aqua"},{"text":"$(clock) ","color":"white"},{"text":"action:","color":"gray"},{"text":"$(action) ","color":"gold"},{"text":"value:","color":"gray"},{"text":"$(value)","color":"yellow"}]