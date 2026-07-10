data modify storage datalib:output result set value ""

$execute if data storage datalib:engine config.$(key) run data modify storage datalib:output result set from storage datalib:engine config.$(key)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"config/get ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
