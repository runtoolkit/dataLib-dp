

$execute as @a[name=$(player),limit=1] at @s run tp @s $(x) $(y) $(z) facing $(fx) $(fy) $(fz)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/tp_facing ","color":"aqua"},{"text":"$(player)","color":"white"}]
