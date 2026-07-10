$execute as @a[name=$(player),limit=1] at @s if items entity @s $(slot) *[minecraft:custom_data=$(customData)] run $(invoke)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"inv/player_slot_if_item ","color":"aqua"},{"text":"$(player)","color":"white"}]
