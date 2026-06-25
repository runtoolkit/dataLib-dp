execute unless data storage datalib:engine _felist_input[0] run execute as @a[tag=datalib.debug] run tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_list ","color":"aqua"},{"text":"DONE ","color":"green"},{"text":"list exhausted, loop ended","color":"#555555"}]}
execute unless data storage datalib:engine _felist_input[0] run return 0

data modify storage datalib:engine _felist_current set from storage datalib:engine _felist_input[0]
execute store result storage datalib:engine _felist_i int 1 run scoreboard players get $felist_i dl.tmp

function datalib:core/internal/lib/for_each_list_call with storage datalib:engine _felist_state

data remove storage datalib:engine _felist_input[0]
scoreboard players add $felist_i dl.tmp 1

function datalib:core/internal/lib/for_each_list_step
