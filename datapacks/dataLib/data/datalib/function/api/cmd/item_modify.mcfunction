
$item modify entity @a[name=$(player),limit=1] $(slot) $(modifier)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/item_modify ","color":"aqua"},{"text":"$(player)","color":"white"}]
