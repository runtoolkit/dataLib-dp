execute if score $rn_i dl.tmp >= $rn_n dl.tmp run return 0

execute store result score $repeat_i dl.tmp run scoreboard players get $rn_i dl.tmp
function datalib:core/internal/lib/repeat_n_call with storage datalib:engine {}
scoreboard players add $rn_i dl.tmp 1
function datalib:core/internal/lib/repeat_n_loop
