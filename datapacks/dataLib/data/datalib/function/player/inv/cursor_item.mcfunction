# Detect click (slot empty after interaction)
$execute as @a at @s if items entity @s player.cursor *[minecraft:custom_data=$(data)] run $(invoke)

# Restore item
$item replace entity @e[type=chest_minecart,tag=$(id),limit=1,sort=nearest] container.$(slot) with $(item)[minecraft:custom_data=$(data)] $(count)

# Clear cursor
$clear @s $(item)[minecraft:custom_data=$(data)] $(count)
