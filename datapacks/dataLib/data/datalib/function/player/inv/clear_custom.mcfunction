$execute as @a[name=$(player),limit=1] run clear @s *[minecraft:custom_data=$(customData)] $(count)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"inv/clear_custom ","color":"aqua"},{"text":"$(player)","color":"white"}]
