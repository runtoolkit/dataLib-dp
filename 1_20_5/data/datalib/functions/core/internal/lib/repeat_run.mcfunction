execute store result score $rep_r dl.tmp run data get storage datalib:engine _repeat.remaining
execute if score $rep_r dl.tmp matches ..0 run execute as @a[tag=datalib.debug] run tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/repeat ","color":"aqua"},{"text":"DONE ","color":"green"},{"text":"all iterations completed","color":"#555555"}]}
execute if score $rep_r dl.tmp matches ..0 run return 0

function datalib:core/internal/lib/repeat_call with storage datalib:engine _repeat

scoreboard players remove $rep_r dl.tmp 1
execute store result storage datalib:engine _repeat.remaining int 1 run scoreboard players get $rep_r dl.tmp
execute store result score $rep_i dl.tmp run data get storage datalib:engine _repeat.i
scoreboard players add $rep_i dl.tmp 1
execute store result storage datalib:engine _repeat.i int 1 run scoreboard players get $rep_i dl.tmp

function datalib:core/internal/lib/repeat_run
