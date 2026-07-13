$scoreboard players set $d2d_x1 dl.tmp $(x1)
$scoreboard players set $d2d_z1 dl.tmp $(z1)
$scoreboard players set $d2d_x2 dl.tmp $(x2)
$scoreboard players set $d2d_z2 dl.tmp $(z2)

scoreboard players operation $d2d_dx dl.tmp = $d2d_x2 dl.tmp
scoreboard players operation $d2d_dx dl.tmp -= $d2d_x1 dl.tmp

scoreboard players operation $d2d_dz dl.tmp = $d2d_z2 dl.tmp
scoreboard players operation $d2d_dz dl.tmp -= $d2d_z1 dl.tmp

# Overflow prevention: 2 * 32767² = 2,147,354,578 ≤ INT_MAX (2,147,483,647)
execute if score $d2d_dx dl.tmp matches 32768.. run scoreboard players set $d2d_dx dl.tmp 32767
execute if score $d2d_dx dl.tmp matches ..-32768 run scoreboard players set $d2d_dx dl.tmp -32767
execute if score $d2d_dz dl.tmp matches 32768.. run scoreboard players set $d2d_dz dl.tmp 32767
execute if score $d2d_dz dl.tmp matches ..-32768 run scoreboard players set $d2d_dz dl.tmp -32767

scoreboard players operation $d2d_dx dl.tmp *= $d2d_dx dl.tmp
scoreboard players operation $d2d_dz dl.tmp *= $d2d_dz dl.tmp
scoreboard players operation $d2d_sq dl.tmp = $d2d_dx dl.tmp
scoreboard players operation $d2d_sq dl.tmp += $d2d_dz dl.tmp

execute if score $d2d_sq dl.tmp matches 0 run data modify storage datalib:output result set value 0
execute if score $d2d_sq dl.tmp matches 0 run return 0

scoreboard players operation $sqrt_n dl.tmp = $d2d_sq dl.tmp
scoreboard players set $sqrt_lo dl.tmp 0
scoreboard players operation $sqrt_hi dl.tmp = $sqrt_n dl.tmp
execute if score $sqrt_hi dl.tmp matches 46342.. run scoreboard players set $sqrt_hi dl.tmp 46341
scoreboard players set $sqrt_itr dl.tmp 16
function datalib:core/internal/systems/math/sqrt_step

execute store result storage datalib:output result int 1 run scoreboard players get $sqrt_lo dl.tmp
