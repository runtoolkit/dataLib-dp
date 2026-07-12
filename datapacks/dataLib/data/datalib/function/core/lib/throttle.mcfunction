scoreboard players set $thr_go dl.tmp 1

$execute if data storage datalib:engine throttle.$(key) run execute store result score $thr_exp dl.tmp run data get storage datalib:engine throttle.$(key)
execute store result score $thr_now dl.tmp run scoreboard players get $epoch datalib.time
$execute if data storage datalib:engine throttle.$(key) run execute if score $thr_now dl.tmp < $thr_exp dl.tmp run scoreboard players set $thr_go dl.tmp 0

$execute if score $thr_go dl.tmp matches 0 run execute as @a[tag=datalib.debug] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/throttle ","color":"aqua"},{"text":"SKIP ","color":"#FF5555"},{"text":"$(key)","color":"aqua"},{"text":" — throttled, skipped","color":"#555555"}]
execute if score $thr_go dl.tmp matches 0 run return 0

$scoreboard players set $thr_int dl.tmp $(interval)
scoreboard players operation $thr_now dl.tmp += $thr_int dl.tmp
$execute store result storage datalib:engine throttle.$(key) int 1 run scoreboard players get $thr_now dl.tmp

function datalib:core/lib/queue_add with storage datalib:input {}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/throttle ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
