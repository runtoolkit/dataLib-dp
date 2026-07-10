tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Trigger Binds ","color":"aqua"},{"text":"━━━━━━━━━━━━━","color":"#555555"}]
execute unless data storage datalib:engine trigger_binds[0] run tellraw @s ["",{"text":" ","color":"#555555"},{"text":"(no binds registered)","color":"gray","italic":true}]
execute if data storage datalib:engine trigger_binds[0] run tellraw @s ["",{"text":" ","color":"#555555"},{"nbt":"trigger_binds","storage":"datalib:engine","interpret":false,"color":"yellow"}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
