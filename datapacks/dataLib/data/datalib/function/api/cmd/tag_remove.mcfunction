
$execute as @a[name=$(player),limit=1] at @s run tag @s remove $(tag)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/tag_remove ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(tag)","color":"aqua"}]
