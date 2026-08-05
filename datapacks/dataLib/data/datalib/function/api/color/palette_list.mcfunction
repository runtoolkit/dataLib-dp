# datalib:api/color/palette_list
# Prints all registered palette entries to the calling player.
# Requires datalib.admin tag.
#
# Usage:
#   function datalib:api/color/palette_list

execute unless entity @s[tag=datalib.admin] run return 0

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Color Palette ","color":"aqua"},{"text":"━━━━━━━━━━━","color":"#555555"}]
execute if data storage datalib:engine color.palette run tellraw @s ["",{"text":" ","color":"#555555"},{"plain":true ,"storage":"datalib:engine","nbt":"color.palette","interpret":false,"color":"green"}]
execute unless data storage datalib:engine color.palette run tellraw @s ["",{"text":" ","color":"#555555"},{"text":"(palette is empty)","color":"gray","italic":true}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
