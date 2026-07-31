# Detect click (slot empty after interaction)
$execute at @s if items entity @s player.cursor $(item)[minecraft:custom_data=$(data)] run $(invoke)
