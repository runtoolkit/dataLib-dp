# datalib:systems/hook/list
# Shows all registered hook binds to datalib.debug players.

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Hook Binds ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━","color":"#555555"}]
execute unless data storage datalib:engine hook_binds[0] run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"text":"(no hook binds)","color":"gray","italic":true}]
execute if data storage datalib:engine hook_binds[0] run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"hook_binds","interpret":false,"color":"yellow"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
