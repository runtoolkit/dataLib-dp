# datalib:debug/menu/log/clear
# Usage: /function datalib:debug/menu/log/clear
# Clears the log buffer.
execute unless entity @s[tag=datalib.admin] run return 0
data remove storage datalib:engine log_display
scoreboard players set #dl.log_count dl.tmp 0
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Log buffer cleared.","color":"gray"}]
