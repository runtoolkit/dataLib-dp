# datalib:core/internal/systems/math/vec/normalize_exec [MACRO]
# INPUT: $(x), $(y), $(z)
# Compute length via math/distance3d, then ×1000 / length
# RULE: Lines without $(var) must NOT have a $ prefix.

function datalib:core/lib/input_push

data modify storage datalib:input x1 set value 0
data modify storage datalib:input y1 set value 0
data modify storage datalib:input z1 set value 0
$data modify storage datalib:input x2 set value $(x)
$data modify storage datalib:input y2 set value $(y)
$data modify storage datalib:input z2 set value $(z)
function datalib:systems/math/distance3d with storage datalib:engine {}

function datalib:core/lib/input_pop

execute store result score $vnlen dl.tmp run data get storage datalib:output result

execute if score $vnlen dl.tmp matches 0 run data modify storage datalib:output x set value 0
execute if score $vnlen dl.tmp matches 0 run data modify storage datalib:output y set value 0
execute if score $vnlen dl.tmp matches 0 run data modify storage datalib:output z set value 0
execute if score $vnlen dl.tmp matches 0 run data modify storage datalib:output length set value 0
execute if score $vnlen dl.tmp matches 0 run return 0

execute store result storage datalib:output length int 1 run scoreboard players get $vnlen dl.tmp

$scoreboard players set $vnx dl.tmp $(x)
scoreboard players set $vn1000 dl.tmp 1000
scoreboard players operation $vnx dl.tmp *= $vn1000 dl.tmp
scoreboard players operation $vnx dl.tmp /= $vnlen dl.tmp
execute store result storage datalib:output x int 1 run scoreboard players get $vnx dl.tmp

$scoreboard players set $vny dl.tmp $(y)
scoreboard players operation $vny dl.tmp *= $vn1000 dl.tmp
scoreboard players operation $vny dl.tmp /= $vnlen dl.tmp
execute store result storage datalib:output y int 1 run scoreboard players get $vny dl.tmp

$scoreboard players set $vnz dl.tmp $(z)
scoreboard players operation $vnz dl.tmp *= $vn1000 dl.tmp
scoreboard players operation $vnz dl.tmp /= $vnlen dl.tmp
execute store result storage datalib:output z int 1 run scoreboard players get $vnz dl.tmp

tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/vec/normalize ","color":"aqua"},{"text":"len=","color":"gray"},{"storage":"datalib:output","nbt":"length","color":"yellow"},{"text":" → ","color":"gray"},{"storage":"datalib:output","nbt":"x","color":"yellow"},{"text":",","color":"gray"},{"storage":"datalib:output","nbt":"y","color":"yellow"},{"text":",","color":"gray"},{"storage":"datalib:output","nbt":"z","color":"yellow"}]}
