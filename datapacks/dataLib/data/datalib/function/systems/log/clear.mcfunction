# datalib:systems/log/clear
# Usage: /function datalib:systems/log/clear
# Clears the log buffer.
execute unless entity @s[tag=datalib.admin] run return 0
data remove storage datalib:engine log_display
scoreboard players set #dl.log_count dl.tmp 0
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Log buffer cleared.","color":"gray"}]
