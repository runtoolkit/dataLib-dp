execute store result storage datalib:engine global.tick int 1 run scoreboard players get $tick dl.tmp
execute store result storage datalib:engine global.epoch int 1 run scoreboard players get $epoch datalib.time
scoreboard players set $tick dl.tmp 0
