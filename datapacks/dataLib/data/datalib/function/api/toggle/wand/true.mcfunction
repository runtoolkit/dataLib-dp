# datalib:api/toggle/wand/true — Enable the wand module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.wand set value 1b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/wand ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
