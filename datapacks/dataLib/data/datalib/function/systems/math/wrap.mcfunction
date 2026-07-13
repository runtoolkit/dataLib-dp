$scoreboard players set $wrap_v dl.tmp $(value)
$scoreboard players set $wrap_min dl.tmp $(min)
$scoreboard players set $wrap_max dl.tmp $(max)

scoreboard players operation $wrap_r dl.tmp = $wrap_max dl.tmp
scoreboard players operation $wrap_r dl.tmp -= $wrap_min dl.tmp

execute if score $wrap_r dl.tmp matches ..0 run execute store result storage datalib:output result int 1 run scoreboard players get $wrap_min dl.tmp
execute if score $wrap_r dl.tmp matches ..0 run return 0

scoreboard players operation $wrap_off dl.tmp = $wrap_v dl.tmp
scoreboard players operation $wrap_off dl.tmp -= $wrap_min dl.tmp

scoreboard players operation $wrap_off dl.tmp %= $wrap_r dl.tmp
execute if score $wrap_off dl.tmp matches ..-1 run scoreboard players operation $wrap_off dl.tmp += $wrap_r dl.tmp

scoreboard players operation $wrap_off dl.tmp += $wrap_min dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $wrap_off dl.tmp
