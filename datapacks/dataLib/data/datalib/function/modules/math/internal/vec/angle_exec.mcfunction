# datalib:systems/math/vec/internal/angle_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)
# RULE: Lines without $(var) must NOT have a $ prefix.

function datalib:runtime/lib/input_push

$data modify storage datalib:engine _vec_dot_tmp ax set value $(ax)
$data modify storage datalib:engine _vec_dot_tmp ay set value $(ay)
$data modify storage datalib:engine _vec_dot_tmp az set value $(az)
$data modify storage datalib:engine _vec_dot_tmp bx set value $(bx)
$data modify storage datalib:engine _vec_dot_tmp by set value $(by)
$data modify storage datalib:engine _vec_dot_tmp bz set value $(bz)
function datalib:modules/math/api/vec/dot with storage datalib:engine _vec_dot_tmp
execute store result score $vang_dot dl.tmp run data get storage datalib:output result

data modify storage datalib:engine _math_d3d_tmp.x1 set value 0
data modify storage datalib:engine _math_d3d_tmp.y1 set value 0
data modify storage datalib:engine _math_d3d_tmp.z1 set value 0
$data modify storage datalib:engine _math_d3d_tmp x2 set value $(ax)
$data modify storage datalib:engine _math_d3d_tmp y2 set value $(ay)
$data modify storage datalib:engine _math_d3d_tmp z2 set value $(az)
function datalib:modules/math/api/distance3d with storage datalib:engine _math_d3d_tmp
execute store result score $vang_la dl.tmp run data get storage datalib:output result

$data modify storage datalib:engine _math_d3d_tmp x2 set value $(bx)
$data modify storage datalib:engine _math_d3d_tmp y2 set value $(by)
$data modify storage datalib:engine _math_d3d_tmp z2 set value $(bz)
function datalib:modules/math/api/distance3d with storage datalib:engine _math_d3d_tmp
execute store result score $vang_lb dl.tmp run data get storage datalib:output result

function datalib:runtime/lib/input_pop

data modify storage datalib:output result set value 0

execute if score $vang_la dl.tmp matches 0 run return 0
execute if score $vang_lb dl.tmp matches 0 run return 0

scoreboard players set $vang_1000 dl.tmp 1000
scoreboard players operation $vang_dot dl.tmp *= $vang_1000 dl.tmp
scoreboard players operation $vang_la dl.tmp *= $vang_lb dl.tmp
scoreboard players operation $vang_dot dl.tmp /= $vang_la dl.tmp

execute if score $vang_dot dl.tmp matches 1001.. run scoreboard players set $vang_dot dl.tmp 1000
execute if score $vang_dot dl.tmp matches ..-1001 run scoreboard players set $vang_dot dl.tmp -1000

execute store result storage datalib:engine _vang_cos int 1 run scoreboard players get $vang_dot dl.tmp
function datalib:modules/math/internal/vec/arccos_lookup
