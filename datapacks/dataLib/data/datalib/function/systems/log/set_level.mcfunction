# datalib:systems/log/set_level
# Usage: $function datalib:systems/log/set_level {level:3}
# Sets the active log level:
#   0 = off
#   1 = error only
#   2 = warn + error
#   3 = info + warn + error  (default)
#   4 = debug (all)
execute unless entity @s[tag=datalib.admin] run return 0
$scoreboard players set #dl.log_level dl.log_level $(level)
$tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Log level set to ","color":"gray"},{"text":"$(level)","color":"white","bold":true}]
