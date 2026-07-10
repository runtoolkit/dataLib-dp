$scoreboard players set $lc_a dl.tmp $(a)
$scoreboard players set $lc_b dl.tmp $(b)
$scoreboard players set $lc_t dl.tmp $(t)

execute if score $lc_t dl.tmp matches ..-1 run scoreboard players set $lc_t dl.tmp 0
scoreboard players set $lc_100 dl.tmp 100
execute if score $lc_t dl.tmp > $lc_100 dl.tmp run scoreboard players operation $lc_t dl.tmp = $lc_100 dl.tmp

scoreboard players operation $lc_r dl.tmp = $lc_b dl.tmp
scoreboard players operation $lc_r dl.tmp -= $lc_a dl.tmp

scoreboard players operation $lc_r dl.tmp *= $lc_t dl.tmp
scoreboard players operation $lc_r dl.tmp /= $lc_100 dl.tmp
scoreboard players operation $lc_r dl.tmp += $lc_a dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $lc_r dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/lerp_clamped ","color":"aqua"},{"text":"a=","color":"#555555"},{"text":"$(a)","color":"white"},{"text":" b=","color":"#555555"},{"text":"$(b)","color":"white"},{"text":" t=","color":"#555555"},{"text":"$(t)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
