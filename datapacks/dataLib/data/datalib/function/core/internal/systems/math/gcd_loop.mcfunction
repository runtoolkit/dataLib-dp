# Euclidean step: a = b, b = a % b — repeat until b is zero
execute if score $gcd_b dl.tmp matches 0 run return 0

scoreboard players operation $gcd_t dl.tmp = $gcd_a dl.tmp
scoreboard players operation $gcd_a dl.tmp = $gcd_b dl.tmp
scoreboard players operation $gcd_t dl.tmp %= $gcd_b dl.tmp
scoreboard players operation $gcd_b dl.tmp = $gcd_t dl.tmp

function datalib:core/internal/systems/math/gcd_loop
