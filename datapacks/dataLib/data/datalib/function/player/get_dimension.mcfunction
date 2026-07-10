data remove storage datalib:output result
$data modify storage datalib:output result set from entity @a[name=$(player),limit=1] Dimension
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/get_dimension ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]