execute if score $lg2_v dl.tmp matches ..1 run return 0

scoreboard players add $lg2_r dl.tmp 1
scoreboard players operation $lg2_v dl.tmp /= $lg2_2 dl.tmp

function datalib:modules/math/internal/log2_loop
