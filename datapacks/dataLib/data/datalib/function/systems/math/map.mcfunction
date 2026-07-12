$scoreboard players set $map_v dl.tmp $(value)
$scoreboard players set $map_imin dl.tmp $(in_min)
$scoreboard players set $map_imax dl.tmp $(in_max)
$scoreboard players set $map_omin dl.tmp $(out_min)
$scoreboard players set $map_omax dl.tmp $(out_max)

scoreboard players operation $map_ir dl.tmp = $map_imax dl.tmp
scoreboard players operation $map_ir dl.tmp -= $map_imin dl.tmp

execute if score $map_ir dl.tmp matches 0 run execute store result storage datalib:output result int 1 run scoreboard players get $map_omin dl.tmp
execute if score $map_ir dl.tmp matches 0 run return 0

scoreboard players operation $map_or dl.tmp = $map_omax dl.tmp
scoreboard players operation $map_or dl.tmp -= $map_omin dl.tmp

scoreboard players operation $map_off dl.tmp = $map_v dl.tmp
scoreboard players operation $map_off dl.tmp -= $map_imin dl.tmp

scoreboard players operation $map_off dl.tmp *= $map_or dl.tmp
scoreboard players operation $map_off dl.tmp /= $map_ir dl.tmp
scoreboard players operation $map_off dl.tmp += $map_omin dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $map_off dl.tmp
