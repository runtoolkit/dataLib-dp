execute unless function datalib:debug/tools/utils/check_all run return 0

# DL - Swing & Feedback Module
$swing @a[name=$(player),limit=1] $(hand)

# System Debug Log for staff (Only for users with 'datalib.debug' tag)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/swing ","color":"aqua"},{"text":"$(player)","color":"white"}]