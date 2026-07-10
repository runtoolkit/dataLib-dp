$scoreboard players set $lg2_v dl.tmp $(value)

execute if score $lg2_v dl.tmp matches ..0 run data modify storage datalib:output result set value -1
execute if score $lg2_v dl.tmp matches ..0 run return 0

scoreboard players set $lg2_r dl.tmp 0
scoreboard players set $lg2_2 dl.tmp 2

function datalib:core/internal/systems/math/log2_loop

execute store result storage datalib:output result int 1 run scoreboard players get $lg2_r dl.tmp
