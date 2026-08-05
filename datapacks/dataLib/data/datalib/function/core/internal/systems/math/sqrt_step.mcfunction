scoreboard players operation $sqrt_mid dl.tmp = $sqrt_lo dl.tmp
scoreboard players operation $sqrt_mid dl.tmp += $sqrt_hi dl.tmp
scoreboard players set $sqrt_2 dl.tmp 2
scoreboard players operation $sqrt_mid dl.tmp /= $sqrt_2 dl.tmp

scoreboard players operation $sqrt_sq dl.tmp = $sqrt_mid dl.tmp
scoreboard players operation $sqrt_sq dl.tmp *= $sqrt_mid dl.tmp

execute if score $sqrt_sq dl.tmp <= $sqrt_n dl.tmp run scoreboard players operation $sqrt_lo dl.tmp = $sqrt_mid dl.tmp
execute unless score $sqrt_sq dl.tmp <= $sqrt_n dl.tmp run scoreboard players operation $sqrt_hi dl.tmp = $sqrt_mid dl.tmp

scoreboard players remove $sqrt_itr dl.tmp 1
execute if score $sqrt_itr dl.tmp matches 1.. run function datalib:core/internal/systems/math/sqrt_step
