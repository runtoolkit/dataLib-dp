# datalib:core/config/score_get
# Prints a config value to the caller (admin only, debug use).
# Usage: $function datalib:core/config/score_get {key:"damage"}
execute unless entity @s[tag=datalib.admin] run return 0
$tellraw @s ["",{"text":"[Config] ","color":"aqua"},{"text":"#$(key)","color":"white"},{"text":" = ","color":"#555555"},{"score":{"name":"#$(key)","objective":"datalib.config"},"color":"green"}]
