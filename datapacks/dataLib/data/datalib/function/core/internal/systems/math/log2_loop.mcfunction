execute if score $lg2_v dl.tmp matches ..1 run return 0

scoreboard players add $lg2_r dl.tmp 1
scoreboard players operation $lg2_v dl.tmp /= $lg2_2 dl.tmp

function datalib:core/internal/systems/math/log2_loop
