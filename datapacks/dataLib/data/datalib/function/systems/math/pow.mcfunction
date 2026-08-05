$scoreboard players set $pow_a dl.tmp $(a)
$scoreboard players set $pow_n dl.tmp $(n)
scoreboard players set $pow_r dl.tmp 1

execute if score $pow_n dl.tmp matches 0 run execute store result storage datalib:output result int 1 run scoreboard players get $pow_r dl.tmp
execute if score $pow_n dl.tmp matches 0 run return 0

function datalib:core/internal/systems/math/pow_loop
execute store result storage datalib:output result int 1 run scoreboard players get $pow_r dl.tmp
