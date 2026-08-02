$scoreboard players set $min_a dl.tmp $(a)
$scoreboard players set $min_b dl.tmp $(b)

execute store result storage datalib:output result int 1 run scoreboard players get $min_a dl.tmp

execute if score $min_b dl.tmp < $min_a dl.tmp run execute store result storage datalib:output result int 1 run scoreboard players get $min_b dl.tmp
