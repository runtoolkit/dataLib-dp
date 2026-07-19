# dl_load:safe_load/no
# Enhanced load cancellation with detailed logging.
# Use INSTEAD OF dl_load:load/no for audited environments.
#
# USAGE:
#   /function dl_load:safe_load/no

# Guard: gate must be open or pending
execute unless score #pending dl.load matches 1 run return 0

# Log via tellraw — no marker entity needed.
tellraw @a ["",{"text":"[DL SAFE GATE] ","color":"#555555"},{"text":"safe_load/no — load CANCELLED by operator.","color":"red"}]
tellraw @a ["",{"text":"[DL SAFE GATE] ","color":"#555555"},{"text":"Storage has NOT been modified.","color":"gray"}]
execute if entity @s[type=minecraft:player] run tellraw @a ["",{"text":"[DL SAFE GATE] ","color":"#555555"},{"text":"Cancelled by a player.","color":"gray"}]
execute unless entity @s[type=minecraft:player] run tellraw @a ["",{"text":"[DL SAFE GATE] ","color":"#555555"},{"text":"Cancelled by server/console.","color":"gray"}]

# Notify player if applicable
execute if entity @s[type=minecraft:player] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"safe_load cancelled. Storage untouched.","color":"yellow"}]

# Delegate to regular load/no
function dl_load:load/no
