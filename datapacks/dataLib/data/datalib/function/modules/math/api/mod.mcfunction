$scoreboard players set $mod_v dl.tmp $(value)
$scoreboard players set $mod_d dl.tmp $(divisor)

execute if score $mod_d dl.tmp matches ..0 run data modify storage datalib:output result set value 0
execute if score $mod_d dl.tmp matches ..0 run return 0

scoreboard players operation $mod_v dl.tmp %= $mod_d dl.tmp

execute if score $mod_v dl.tmp matches ..-1 run scoreboard players operation $mod_v dl.tmp += $mod_d dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $mod_v dl.tmp
