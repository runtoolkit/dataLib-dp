$scoreboard players set $mmx_a dl.tmp $(a)
$scoreboard players set $mmx_b dl.tmp $(b)

scoreboard players operation $mmx_lo dl.tmp = $mmx_a dl.tmp
execute if score $mmx_b dl.tmp < $mmx_a dl.tmp run scoreboard players operation $mmx_lo dl.tmp = $mmx_b dl.tmp

scoreboard players operation $mmx_hi dl.tmp = $mmx_a dl.tmp
execute if score $mmx_b dl.tmp > $mmx_a dl.tmp run scoreboard players operation $mmx_hi dl.tmp = $mmx_b dl.tmp

execute store result storage datalib:output min int 1 run scoreboard players get $mmx_lo dl.tmp
execute store result storage datalib:output max int 1 run scoreboard players get $mmx_hi dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/minmax ","color":"aqua"},{"text":"($(a),$(b))","color":"gray"},{"text":" → ","color":"#555555"},{"text":"min=","color":"gray"},{"storage":"datalib:output","nbt":"min","color":"green"},{"text":" max=","color":"gray"},{"storage":"datalib:output","nbt":"max","color":"green"}]
