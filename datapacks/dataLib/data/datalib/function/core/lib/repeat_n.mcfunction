$scoreboard players set $rn_n dl.tmp $(n)
scoreboard players set $rn_i dl.tmp 0

execute if score $rn_n dl.tmp matches ..0 run return 0

$data modify storage datalib:engine _rn_func set value "$(func)"
function datalib:core/internal/core/lib/repeat_n_loop
data remove storage datalib:engine _rn_func
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/repeat_n ","color":"aqua"},{"text":"$(func) × $(n)","color":"aqua"}]
