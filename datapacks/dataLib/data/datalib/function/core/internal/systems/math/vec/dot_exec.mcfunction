# datalib:systems/math/vec/internal/dot_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)

$scoreboard players set $vdax dl.tmp $(ax)
$scoreboard players set $vdbx dl.tmp $(bx)
scoreboard players operation $vdax dl.tmp *= $vdbx dl.tmp

$scoreboard players set $vday dl.tmp $(ay)
$scoreboard players set $vdby dl.tmp $(by)
scoreboard players operation $vday dl.tmp *= $vdby dl.tmp

$scoreboard players set $vdaz dl.tmp $(az)
$scoreboard players set $vdbz dl.tmp $(bz)
scoreboard players operation $vdaz dl.tmp *= $vdbz dl.tmp

scoreboard players operation $vdax dl.tmp += $vday dl.tmp
scoreboard players operation $vdax dl.tmp += $vdaz dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $vdax dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/vec/dot ","color":"aqua"},{"text":"($(ax),$(ay),$(az))·($(bx),$(by),$(bz)) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"yellow"}]
