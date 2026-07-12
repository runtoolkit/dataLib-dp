$execute as @a[name=$(player),limit=1] at @s unless entity @e[type=$(type),tag=$(tag),distance=..$(distance),limit=1] run $(invoke)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo/near_entity_unless ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
