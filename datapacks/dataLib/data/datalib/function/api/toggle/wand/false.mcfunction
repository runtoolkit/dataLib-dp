# datalib:api/toggle/wand/false — Disable the wand module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.wand set value 0b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/wand ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
