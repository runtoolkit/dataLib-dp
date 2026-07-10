data modify storage datalib:output result set value 0b

$scoreboard players set $rgn_x dl.tmp $(x)
$scoreboard players set $rgn_y dl.tmp $(y)
$scoreboard players set $rgn_z dl.tmp $(z)
$scoreboard players set $rgn_x1 dl.tmp $(x1)
$scoreboard players set $rgn_y1 dl.tmp $(y1)
$scoreboard players set $rgn_z1 dl.tmp $(z1)
$scoreboard players set $rgn_x2 dl.tmp $(x2)
$scoreboard players set $rgn_y2 dl.tmp $(y2)
$scoreboard players set $rgn_z2 dl.tmp $(z2)

# min/max normalization
execute if score $rgn_x1 dl.tmp > $rgn_x2 dl.tmp run scoreboard players operation $rgn_t dl.tmp = $rgn_x1 dl.tmp
execute if score $rgn_x1 dl.tmp > $rgn_x2 dl.tmp run scoreboard players operation $rgn_x1 dl.tmp = $rgn_x2 dl.tmp
execute if score $rgn_t dl.tmp > $rgn_x2 dl.tmp run scoreboard players operation $rgn_x2 dl.tmp = $rgn_t dl.tmp

execute if score $rgn_y1 dl.tmp > $rgn_y2 dl.tmp run scoreboard players operation $rgn_t dl.tmp = $rgn_y1 dl.tmp
execute if score $rgn_y1 dl.tmp > $rgn_y2 dl.tmp run scoreboard players operation $rgn_y1 dl.tmp = $rgn_y2 dl.tmp
execute if score $rgn_t dl.tmp > $rgn_y2 dl.tmp run scoreboard players operation $rgn_y2 dl.tmp = $rgn_t dl.tmp

execute if score $rgn_z1 dl.tmp > $rgn_z2 dl.tmp run scoreboard players operation $rgn_t dl.tmp = $rgn_z1 dl.tmp
execute if score $rgn_z1 dl.tmp > $rgn_z2 dl.tmp run scoreboard players operation $rgn_z1 dl.tmp = $rgn_z2 dl.tmp
execute if score $rgn_t dl.tmp > $rgn_z2 dl.tmp run scoreboard players operation $rgn_z2 dl.tmp = $rgn_t dl.tmp

execute if score $rgn_x dl.tmp < $rgn_x1 dl.tmp run return 0
execute if score $rgn_x dl.tmp > $rgn_x2 dl.tmp run return 0
execute if score $rgn_y dl.tmp < $rgn_y1 dl.tmp run return 0
execute if score $rgn_y dl.tmp > $rgn_y2 dl.tmp run return 0
execute if score $rgn_z dl.tmp < $rgn_z1 dl.tmp run return 0
execute if score $rgn_z dl.tmp > $rgn_z2 dl.tmp run return 0

data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo/in_region ","color":"aqua"},{"text":"($(x),$(y),$(z)) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
