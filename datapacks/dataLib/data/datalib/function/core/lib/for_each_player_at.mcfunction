$data modify storage datalib:engine _dispatch.func set value "$(func)"
execute as @a at @s run function #datalib:internal/dispatch
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_player_at ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
