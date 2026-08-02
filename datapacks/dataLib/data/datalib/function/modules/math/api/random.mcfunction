$scoreboard players set $rnd_min dl.tmp $(min)
$scoreboard players set $rnd_max dl.tmp $(max)

scoreboard players operation $rnd_max dl.tmp -= $rnd_min dl.tmp
scoreboard players add $rnd_max dl.tmp 1

execute if data storage datalib:engine _rng_state run execute store result score $rnd dl.tmp run data get storage datalib:engine _rng_state
execute unless data storage datalib:engine _rng_state run execute store result score $rnd dl.tmp run scoreboard players get $epoch datalib.time
execute unless data storage datalib:engine _rng_state run scoreboard players add $rnd dl.tmp 57005

scoreboard players set $rnd_tick dl.tmp 31
execute store result score $rnd_t dl.tmp run scoreboard players get $tick dl.tmp
scoreboard players operation $rnd_t dl.tmp *= $rnd_tick dl.tmp
scoreboard players operation $rnd dl.tmp += $rnd_t dl.tmp

scoreboard players set $rnd_a dl.tmp 1664525
scoreboard players operation $rnd dl.tmp *= $rnd_a dl.tmp
scoreboard players add $rnd dl.tmp 1013904223

execute store result storage datalib:engine _rng_state int 1 run scoreboard players get $rnd dl.tmp

execute if score $rnd dl.tmp matches -2147483648 run scoreboard players set $rnd dl.tmp 2147483647
execute if score $rnd dl.tmp matches ..-1 run scoreboard players set $rnd_neg dl.tmp -1
execute if score $rnd dl.tmp matches ..-1 run scoreboard players operation $rnd dl.tmp *= $rnd_neg dl.tmp

scoreboard players operation $rnd dl.tmp %= $rnd_max dl.tmp
execute if score $rnd dl.tmp matches ..-1 run scoreboard players operation $rnd dl.tmp += $rnd_max dl.tmp
scoreboard players operation $rnd dl.tmp += $rnd_min dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $rnd dl.tmp
