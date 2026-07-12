$scoreboard players set $ttt_t dl.tmp $(ticks)

execute if score $ttt_t dl.tmp matches ..-1 run scoreboard players set $ttt_t dl.tmp 0

scoreboard players operation $ttt_r dl.tmp = $ttt_t dl.tmp
scoreboard players set $ttt_20 dl.tmp 20
scoreboard players operation $ttt_r dl.tmp %= $ttt_20 dl.tmp
execute store result storage datalib:output ticks int 1 run scoreboard players get $ttt_r dl.tmp

scoreboard players operation $ttt_t dl.tmp /= $ttt_20 dl.tmp

scoreboard players operation $ttt_r dl.tmp = $ttt_t dl.tmp
scoreboard players set $ttt_60 dl.tmp 60
scoreboard players operation $ttt_r dl.tmp %= $ttt_60 dl.tmp
execute store result storage datalib:output seconds int 1 run scoreboard players get $ttt_r dl.tmp

scoreboard players operation $ttt_t dl.tmp /= $ttt_60 dl.tmp

scoreboard players operation $ttt_r dl.tmp = $ttt_t dl.tmp
scoreboard players operation $ttt_r dl.tmp %= $ttt_60 dl.tmp
execute store result storage datalib:output minutes int 1 run scoreboard players get $ttt_r dl.tmp

scoreboard players operation $ttt_t dl.tmp /= $ttt_60 dl.tmp
execute store result storage datalib:output hours int 1 run scoreboard players get $ttt_t dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/ticks_to_time ","color":"aqua"},{"text":"($(ticks)t)","color":"gray"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"hours","color":"green"},{"text":"h ","color":"gray"},{"storage":"datalib:output","nbt":"minutes","color":"green"},{"text":"m ","color":"gray"},{"storage":"datalib:output","nbt":"seconds","color":"green"},{"text":"s ","color":"gray"},{"storage":"datalib:output","nbt":"ticks","color":"green"},{"text":"t","color":"gray"}]
