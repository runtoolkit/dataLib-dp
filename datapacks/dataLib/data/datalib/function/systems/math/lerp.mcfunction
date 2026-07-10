$scoreboard players set $lerp_a dl.tmp $(a)
$scoreboard players set $lerp_b dl.tmp $(b)
$scoreboard players set $lerp_t dl.tmp $(t)

scoreboard players operation $lerp_r dl.tmp = $lerp_b dl.tmp
scoreboard players operation $lerp_r dl.tmp -= $lerp_a dl.tmp

scoreboard players operation $lerp_r dl.tmp *= $lerp_t dl.tmp
scoreboard players set $lerp_100 dl.tmp 100
scoreboard players operation $lerp_r dl.tmp /= $lerp_100 dl.tmp
scoreboard players operation $lerp_r dl.tmp += $lerp_a dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $lerp_r dl.tmp
