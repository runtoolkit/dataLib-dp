# datalib:api/toggle/geo/true — Enable the geo/region_watch module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.geo set value 1b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/geo ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
