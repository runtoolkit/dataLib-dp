data remove storage datalib:output result
$execute if data storage datalib:engine states.$(player) run data modify storage datalib:output result set from storage datalib:engine states.$(player)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"state/get ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
