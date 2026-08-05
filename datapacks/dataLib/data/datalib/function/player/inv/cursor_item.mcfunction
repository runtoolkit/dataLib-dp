# Detect click (slot empty after interaction)
$execute as @a[name=$(player),limit=1] at @s if items entity @s player.cursor $(item)[minecraft:custom_data=$(data)] run $(invoke)
