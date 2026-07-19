# datalib:api/toggle/interaction/true — Enable the interaction (IE) module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.interaction set value 1b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"interaction","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/interaction ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
