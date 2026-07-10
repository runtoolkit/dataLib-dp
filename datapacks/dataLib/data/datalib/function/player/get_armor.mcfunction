# ─────────────────────────────────────────────────────────────────
# datalib:player/get_armor
# Returns the armor point value of the named player.
# Armor is read from the generic.armor attribute base value.
# Also returns armor toughness.
#
# INPUT : $(player) → player name
# OUTPUT: datalib:output result → armor points (int)
# datalib:output toughness → armor toughness (int, scaled x1000)
# datalib:output found → 1b if player exists, 0b otherwise
#
# EXAMPLE:
# function datalib:player/get_armor {player:"Steve"}
# data get storage datalib:output result
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage datalib:output found set value 1b
$execute as @a[name=$(player),limit=1] store result storage datalib:output result int 1 run data get entity @s Attributes[{Name:"minecraft:armor"}].Base
$execute as @a[name=$(player),limit=1] store result storage datalib:output toughness int 1000 run data get entity @s Attributes[{Name:"minecraft:armor_toughness"}].Base
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/get_armor ","color":"aqua"},{"text":"$(player) → armor=","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"},{"text":" toughness=","color":"gray"},{"storage":"datalib:output","nbt":"toughness","color":"green"}]