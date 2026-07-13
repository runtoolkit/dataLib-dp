# datalib:api/toggle/hook/true — Enable the hook module
# Called by the module toggle dialog when State = true.
# Caller: datalib.admin tag required (enforced by dialog show guard in show.mcfunction)

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.hook set value 1b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"hook","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/hook ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
