$scoreboard players set $abs_v dl.tmp $(value)
scoreboard players set $abs_neg dl.tmp -1
execute if score $abs_v dl.tmp matches ..-1 run scoreboard players operation $abs_v dl.tmp *= $abs_neg dl.tmp
execute store result storage datalib:output result int 1 run scoreboard players get $abs_v dl.tmp
