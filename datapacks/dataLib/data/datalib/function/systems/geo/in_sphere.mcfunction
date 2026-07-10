data modify storage datalib:output result set value 0b

$scoreboard players set $sph_dx dl.tmp $(x)
$scoreboard players set $sph_cx dl.tmp $(cx)
scoreboard players operation $sph_dx dl.tmp -= $sph_cx dl.tmp

$scoreboard players set $sph_dy dl.tmp $(y)
$scoreboard players set $sph_cy dl.tmp $(cy)
scoreboard players operation $sph_dy dl.tmp -= $sph_cy dl.tmp

$scoreboard players set $sph_dz dl.tmp $(z)
$scoreboard players set $sph_cz dl.tmp $(cz)
scoreboard players operation $sph_dz dl.tmp -= $sph_cz dl.tmp

# Overflow prevention (max 26754 per axis)
execute if score $sph_dx dl.tmp matches 26755.. run scoreboard players set $sph_dx dl.tmp 26754
execute if score $sph_dx dl.tmp matches ..-26755 run scoreboard players set $sph_dx dl.tmp -26754
execute if score $sph_dy dl.tmp matches 26755.. run scoreboard players set $sph_dy dl.tmp 26754
execute if score $sph_dy dl.tmp matches ..-26755 run scoreboard players set $sph_dy dl.tmp -26754
execute if score $sph_dz dl.tmp matches 26755.. run scoreboard players set $sph_dz dl.tmp 26754
execute if score $sph_dz dl.tmp matches ..-26755 run scoreboard players set $sph_dz dl.tmp -26754

scoreboard players operation $sph_dx dl.tmp *= $sph_dx dl.tmp
scoreboard players operation $sph_dy dl.tmp *= $sph_dy dl.tmp
scoreboard players operation $sph_dz dl.tmp *= $sph_dz dl.tmp

scoreboard players operation $sph_dsq dl.tmp = $sph_dx dl.tmp
scoreboard players operation $sph_dsq dl.tmp += $sph_dy dl.tmp
scoreboard players operation $sph_dsq dl.tmp += $sph_dz dl.tmp
execute store result storage datalib:output dist_sq int 1 run scoreboard players get $sph_dsq dl.tmp

$scoreboard players set $sph_r dl.tmp $(r)
scoreboard players operation $sph_r dl.tmp *= $sph_r dl.tmp

execute if score $sph_dsq dl.tmp <= $sph_r dl.tmp run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo/in_sphere ","color":"aqua"},{"text":"r=$(r) dsq=","color":"gray"},{"score":{"name":"$sph_dsq","objective":"dl.tmp"},"color":"yellow"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
