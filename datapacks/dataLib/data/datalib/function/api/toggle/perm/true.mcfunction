# datalib:api/toggle/perm/true — Enable the perm trigger module

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.perm set value 1b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/perm ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
