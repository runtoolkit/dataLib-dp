execute unless function datalib:debug/tools/utils/check_all run return 0

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Admin List ","color":"aqua"},{"text":"━━━━━━━━━━━━━━","color":"#555555"}]
execute if entity @a[tag=datalib.admin] run tellraw @s ["",{"text":" ◈ ","color":"#00AAAA"},{"selector":"@a[tag=datalib.admin]","color":"white"}]
execute unless entity @a[tag=datalib.admin] run tellraw @s ["",{"text":" ","color":"#555555"},{"text":"(no admins)","color":"gray","italic":true}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
