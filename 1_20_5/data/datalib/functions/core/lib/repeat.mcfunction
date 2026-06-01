$data modify storage datalib:engine _repeat.func set value "$(func)"
$scoreboard players set $rep_n dl.tmp $(count)
scoreboard players set $rep_i dl.tmp 0
execute store result storage datalib:engine _repeat.i int 1 run scoreboard players get $rep_i dl.tmp
execute store result storage datalib:engine _repeat.remaining int 1 run scoreboard players get $rep_n dl.tmp
function datalib:core/internal/lib/repeat_run
data remove storage datalib:engine _repeat
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/repeat ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]}
