# datalib:api/toggle/interaction/false — Disable the interaction (IE) module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.interaction set value 0b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"interaction","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/interaction ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
