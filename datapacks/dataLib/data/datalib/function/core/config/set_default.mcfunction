data modify storage datalib:output result set value 1b

$execute if data storage datalib:engine config.$(key) run data modify storage datalib:output result set value 0b
$execute if data storage datalib:engine config.$(key) run return 0

$data modify storage datalib:engine config.$(key) set value "$(value)"
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"config/set_default ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
