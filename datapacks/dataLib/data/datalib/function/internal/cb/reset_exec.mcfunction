# Macro: receives {x, y, z}
$data modify block $(x) $(y) $(z) auto set value 0b
$setblock $(x) $(y) $(z) minecraft:air replace
$forceload remove $(x) $(z)
