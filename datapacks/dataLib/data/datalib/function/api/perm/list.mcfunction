$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Perms: ","color":"aqua"},{"text":"$(player)","color":"white","bold":true},{"text":" ━━━━━━━━━━━━━━","color":"#555555"}]
$execute if data storage datalib:engine permissions.$(player) run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"permissions.$(player)","interpret":false,"color":"yellow"}]
$execute unless data storage datalib:engine permissions.$(player) run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"text":"(no permissions)","color":"gray","italic":true}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
