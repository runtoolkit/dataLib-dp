# datalib:systems/math/vec/internal/cross_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)

# cx = ay*bz - az*by
$scoreboard players set $vcay dl.tmp $(ay)
$scoreboard players set $vcbz dl.tmp $(bz)
scoreboard players operation $vcay dl.tmp *= $vcbz dl.tmp

$scoreboard players set $vcaz dl.tmp $(az)
$scoreboard players set $vcby dl.tmp $(by)
scoreboard players operation $vcaz dl.tmp *= $vcby dl.tmp

scoreboard players operation $vcay dl.tmp -= $vcaz dl.tmp
execute store result storage datalib:output x int 1 run scoreboard players get $vcay dl.tmp

# cy = az*bx - ax*bz
$scoreboard players set $vcaz2 dl.tmp $(az)
$scoreboard players set $vcbx dl.tmp $(bx)
scoreboard players operation $vcaz2 dl.tmp *= $vcbx dl.tmp

$scoreboard players set $vcax dl.tmp $(ax)
$scoreboard players set $vcbz2 dl.tmp $(bz)
scoreboard players operation $vcax dl.tmp *= $vcbz2 dl.tmp

scoreboard players operation $vcaz2 dl.tmp -= $vcax dl.tmp
execute store result storage datalib:output y int 1 run scoreboard players get $vcaz2 dl.tmp

# cz = ax*by - ay*bx
$scoreboard players set $vcax2 dl.tmp $(ax)
$scoreboard players set $vcby2 dl.tmp $(by)
scoreboard players operation $vcax2 dl.tmp *= $vcby2 dl.tmp

$scoreboard players set $vcay2 dl.tmp $(ay)
$scoreboard players set $vcbx2 dl.tmp $(bx)
scoreboard players operation $vcay2 dl.tmp *= $vcbx2 dl.tmp

scoreboard players operation $vcax2 dl.tmp -= $vcay2 dl.tmp
execute store result storage datalib:output z int 1 run scoreboard players get $vcax2 dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/vec/cross ","color":"aqua"},{"text":"($(ax),$(ay),$(az))×($(bx),$(by),$(bz)) → ","color":"gray"},{"storage":"datalib:output","nbt":"x","color":"yellow"},{"text":",","color":"gray"},{"storage":"datalib:output","nbt":"y","color":"yellow"},{"text":",","color":"gray"},{"storage":"datalib:output","nbt":"z","color":"yellow"}]
