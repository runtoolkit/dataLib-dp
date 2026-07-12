$execute as @a at @s unless items entity @e[type=minecraft:chest_minecart,distance=..2,limit=1,tag=$(tag)] container.$(slot) *[minecraft:custom_data=$(customData)] run $(invoke)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"inv/chest_minecart_unless_item ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(tag)","color":"aqua"}]
