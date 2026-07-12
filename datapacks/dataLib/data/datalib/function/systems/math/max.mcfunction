$scoreboard players set $max_a dl.tmp $(a)
$scoreboard players set $max_b dl.tmp $(b)

execute store result storage datalib:output result int 1 run scoreboard players get $max_a dl.tmp

execute if score $max_b dl.tmp > $max_a dl.tmp run execute store result storage datalib:output result int 1 run scoreboard players get $max_b dl.tmp
