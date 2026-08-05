

$execute as @a[name=$(player),limit=1] at @s run kill @s
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/kill ","color":"aqua"},{"text":"$(player)","color":"white"}]
