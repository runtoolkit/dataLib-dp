$execute if data storage datalib:engine once_keys.$(key) run return 0

$data modify storage datalib:engine once_keys.$(key) set value 1b

$data modify storage datalib:engine _dispatch.func set value "$(func)"
function #datalib:internal/dispatch

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/once ","color":"aqua"},{"text":"[fired] ","color":"green"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"white"}]
