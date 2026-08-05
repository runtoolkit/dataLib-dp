$scoreboard players set $d3d_x1 dl.tmp $(x1)
$scoreboard players set $d3d_y1 dl.tmp $(y1)
$scoreboard players set $d3d_z1 dl.tmp $(z1)
$scoreboard players set $d3d_x2 dl.tmp $(x2)
$scoreboard players set $d3d_y2 dl.tmp $(y2)
$scoreboard players set $d3d_z2 dl.tmp $(z2)

scoreboard players operation $d3d_dx dl.tmp = $d3d_x2 dl.tmp
scoreboard players operation $d3d_dx dl.tmp -= $d3d_x1 dl.tmp

scoreboard players operation $d3d_dy dl.tmp = $d3d_y2 dl.tmp
scoreboard players operation $d3d_dy dl.tmp -= $d3d_y1 dl.tmp

scoreboard players operation $d3d_dz dl.tmp = $d3d_z2 dl.tmp
scoreboard players operation $d3d_dz dl.tmp -= $d3d_z1 dl.tmp

# Overflow prevention: 3 * 26754² = 2,147,329,548 ≤ INT_MAX (2,147,483,647)
execute if score $d3d_dx dl.tmp matches 26755.. run scoreboard players set $d3d_dx dl.tmp 26754
execute if score $d3d_dx dl.tmp matches ..-26755 run scoreboard players set $d3d_dx dl.tmp -26754
execute if score $d3d_dy dl.tmp matches 26755.. run scoreboard players set $d3d_dy dl.tmp 26754
execute if score $d3d_dy dl.tmp matches ..-26755 run scoreboard players set $d3d_dy dl.tmp -26754
execute if score $d3d_dz dl.tmp matches 26755.. run scoreboard players set $d3d_dz dl.tmp 26754
execute if score $d3d_dz dl.tmp matches ..-26755 run scoreboard players set $d3d_dz dl.tmp -26754

scoreboard players operation $d3d_dx dl.tmp *= $d3d_dx dl.tmp
scoreboard players operation $d3d_dy dl.tmp *= $d3d_dy dl.tmp
scoreboard players operation $d3d_dz dl.tmp *= $d3d_dz dl.tmp
scoreboard players operation $d3d_sq dl.tmp = $d3d_dx dl.tmp
scoreboard players operation $d3d_sq dl.tmp += $d3d_dy dl.tmp
scoreboard players operation $d3d_sq dl.tmp += $d3d_dz dl.tmp

execute if score $d3d_sq dl.tmp matches 0 run data modify storage datalib:output result set value 0
execute if score $d3d_sq dl.tmp matches 0 run return 0

scoreboard players operation $sqrt_n dl.tmp = $d3d_sq dl.tmp
scoreboard players set $sqrt_lo dl.tmp 0
scoreboard players operation $sqrt_hi dl.tmp = $sqrt_n dl.tmp
execute if score $sqrt_hi dl.tmp matches 46342.. run scoreboard players set $sqrt_hi dl.tmp 46341
scoreboard players set $sqrt_itr dl.tmp 16
function datalib:core/internal/systems/math/sqrt_step

execute store result storage datalib:output result int 1 run scoreboard players get $sqrt_lo dl.tmp
