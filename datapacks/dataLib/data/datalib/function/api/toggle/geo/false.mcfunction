# datalib:api/toggle/geo/false — Disable the geo/region_watch module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.geo set value 0b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/geo ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
