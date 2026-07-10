execute unless function datalib:debug/tools/utils/check_all run return 0

# DL - World Clock Rate Controller
$time rate $(rate)

# System Debug Log for staff (Only for users with 'datalib.debug' tag)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"clock/rate_updated ","color":"aqua"},{"text":"* ","color":"white"},{"text":"to ","color":"gray"},{"text":"$(rate)x","color":"gold"}]