
$execute as @a[name=$(player),limit=1] run enchant @s $(enchantment) $(level)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/enchant ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(enchantment)","color":"aqua"}]
