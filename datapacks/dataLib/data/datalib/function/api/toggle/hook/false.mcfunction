# datalib:api/toggle/hook/false — Disable the hook module
# Called by the module toggle dialog when State = false.
# Caller: datalib.admin tag required (enforced by dialog show guard in show.mcfunction)

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine modules.hook set value 0b

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"hook","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/hook ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
