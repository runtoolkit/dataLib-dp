


$execute as @a[name=$(player),limit=1] at @s run gamemode $(mode) @s
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/gamemode ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(mode)","color":"aqua"}]
