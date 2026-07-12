execute if score $pow_n dl.tmp matches ..0 run return 0
scoreboard players operation $pow_r dl.tmp *= $pow_a dl.tmp
scoreboard players remove $pow_n dl.tmp 1
function datalib:core/internal/systems/math/pow_loop
