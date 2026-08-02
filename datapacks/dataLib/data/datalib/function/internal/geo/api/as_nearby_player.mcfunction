$data modify storage datalib:engine _dispatch.func set value "$(func)"
$execute as @a[distance=..$(distance),limit=1,sort=nearest] at @s run function #datalib:internal/dispatch
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo/as_nearby_player ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
