# datalib:systems/flag/list_systems — List all tick channels with their current config
tellraw @s [{"text":"[DL] Tick Channels","color":"gold","bold":true}]
tellraw @s {"storage":"datalib:engine","nbt":"tick.channels","color":"yellow"}