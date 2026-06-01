$data modify storage datalib:engine _felist_state set value {func:"$(func)"}
scoreboard players set $felist_i dl.tmp 0
function datalib:core/internal/lib/for_each_list_step

data remove storage datalib:engine _felist_input
data remove storage datalib:engine _felist_state
data remove storage datalib:engine _felist_current
data remove storage datalib:engine _felist_i
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_list ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]}
