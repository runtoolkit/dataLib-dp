# datalib:systems/security/menu  [compat_1_21_4 OVERLAY — pre-1.21.5 syntax]
# Security status panel for pack formats 48-61 (1.21.4 and below).
# Uses old clickEvent/hoverEvent syntax (renamed in 1.21.5).
# Requires: dl.perm_level >= security.admin_min_level
execute unless function datalib:debug/tools/utils/perm_check run return 0
tellraw @s ["",{"text":"─── DL Security ─────────────────────","color":"#00AAAA","bold":true}]
tellraw @s ["",{"text":"  Version         ","color":"gray"},{"storage":"datalib:engine","nbt":"global.version","color":"aqua"}]
tellraw @s ["",{"text":"  sandbox         ","color":"gray"},{"storage":"datalib:engine","nbt":"sandbox","color":"gold"}]
tellraw @s ["",{"text":"  trust_players   ","color":"gray"},{"storage":"datalib:engine","nbt":"security.trust_players","color":"gold"}]
tellraw @s ["",{"text":"  cmd_min_level   ","color":"gray"},{"storage":"datalib:engine","nbt":"security.cmd_min_level","color":"green"}]
tellraw @s ["",{"text":"  sandbox_level   ","color":"gray"},{"storage":"datalib:engine","nbt":"security.sandbox_cmd_min_level","color":"green"}]
tellraw @s ["",{"text":"  admin_min_level ","color":"gray"},{"storage":"datalib:engine","nbt":"security.admin_min_level","color":"green"}]
tellraw @s ["",{"text":"  admin_override  ","color":"gray"},{"storage":"datalib:engine","nbt":"security.admin_can_override","color":"gold"}]
tellraw @s ["",{"text":"  Your level      ","color":"gray"},{"score":{"name":"@s","objective":"dl.perm_level"},"color":"yellow","bold":true}]
tellraw @s ["",{"text":"  [sandbox on] ","color":"green","clickEvent":{"action":"suggest_command","value":"/data modify storage datalib:engine sandbox set value 1b"},"hoverEvent":{"action":"show_text","value":"Suggest: enable sandbox"}},{"text":"[sandbox off]","color":"red","clickEvent":{"action":"suggest_command","value":"/data modify storage datalib:engine sandbox set value 0b"},"hoverEvent":{"action":"show_text","value":"Suggest: disable sandbox"}}]
