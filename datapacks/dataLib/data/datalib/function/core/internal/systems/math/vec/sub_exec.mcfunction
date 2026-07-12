# datalib:systems/math/vec/internal/sub_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)

$scoreboard players set $vx dl.tmp $(ax)
$scoreboard players set $vy dl.tmp $(ay)
$scoreboard players set $vz dl.tmp $(az)
$scoreboard players remove $vx dl.tmp $(bx)
$scoreboard players remove $vy dl.tmp $(by)
$scoreboard players remove $vz dl.tmp $(bz)

execute store result storage datalib:output x int 1 run scoreboard players get $vx dl.tmp
execute store result storage datalib:output y int 1 run scoreboard players get $vy dl.tmp
execute store result storage datalib:output z int 1 run scoreboard players get $vz dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/vec/sub ","color":"aqua"},{"text":"($(ax),$(ay),$(az))-($(bx),$(by),$(bz)) → ","color":"gray"},{"storage":"datalib:output","nbt":"x","color":"yellow"},{"text":",","color":"gray"},{"storage":"datalib:output","nbt":"y","color":"yellow"},{"text":",","color":"gray"},{"storage":"datalib:output","nbt":"z","color":"yellow"}]
