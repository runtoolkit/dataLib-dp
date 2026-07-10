$scoreboard players set $cdv_a dl.tmp $(a)
$scoreboard players set $cdv_b dl.tmp $(b)

scoreboard players operation $cdv_t dl.tmp = $cdv_b dl.tmp
scoreboard players remove $cdv_t dl.tmp 1

scoreboard players operation $cdv_a dl.tmp += $cdv_t dl.tmp

scoreboard players operation $cdv_a dl.tmp /= $cdv_b dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $cdv_a dl.tmp
