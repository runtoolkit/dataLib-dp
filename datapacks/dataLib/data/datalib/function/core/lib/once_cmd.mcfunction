$execute if data storage datalib:engine once_keys.$(key) run return 0

$data modify storage datalib:engine once_keys.$(key) set value 1b

# SECURITY: central gate
execute unless function datalib:core/security/cmd_gate run return 0

tellraw @a[tag=datalib.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/once_cmd ","color":"aqua"},{"text":"[fired] ","color":"green"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(cmd)","color":"white"}]
