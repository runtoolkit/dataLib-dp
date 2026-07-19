execute unless function datalib:debug/tools/utils/check_all run return 0

$execute as @a[name=$(player),limit=1] at @s run effect give @s minecraft:instant_health 1 $(amount) true
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/heal ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(amount)","color":"aqua"}]
