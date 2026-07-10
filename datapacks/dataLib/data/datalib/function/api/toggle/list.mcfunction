# datalib:api/toggle/list
# Prints the enabled/disabled state of all DL modules.
#
# Usage:  function datalib:api/toggle/list
# Caller: datalib.admin tag required

execute unless entity @s[tag=datalib.admin] run return 0

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Module States ━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"modules","interpret":false,"color":"yellow"}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
