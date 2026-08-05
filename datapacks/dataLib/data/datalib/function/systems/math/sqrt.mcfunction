$scoreboard players set $sqrt_n dl.tmp $(value)

execute if score $sqrt_n dl.tmp matches ..0 run data modify storage datalib:output result set value 0
execute if score $sqrt_n dl.tmp matches ..0 run return 0

execute if score $sqrt_n dl.tmp matches 1 run data modify storage datalib:output result set value 1
execute if score $sqrt_n dl.tmp matches 1 run return 0

scoreboard players set $sqrt_lo dl.tmp 0
scoreboard players operation $sqrt_hi dl.tmp = $sqrt_n dl.tmp
execute if score $sqrt_hi dl.tmp matches 46342.. run scoreboard players set $sqrt_hi dl.tmp 46341

scoreboard players set $sqrt_itr dl.tmp 16
function datalib:core/internal/systems/math/sqrt_step

execute store result storage datalib:output result int 1 run scoreboard players get $sqrt_lo dl.tmp
