scoreboard players set $poc dl.tmp 0
execute as @a run scoreboard players add $poc dl.tmp 1
execute store result storage datalib:output result int 1 run scoreboard players get $poc dl.tmp