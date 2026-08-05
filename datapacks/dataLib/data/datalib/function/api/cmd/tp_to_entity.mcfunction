

$execute as @a[name=$(player),limit=1] run tp @s @e[type=$(type),tag=$(tag),limit=1]
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/tp_to_entity ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
