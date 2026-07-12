tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Active Schedules ","color":"aqua"},{"text":"━━━━━━━━━","color":"#555555"}]
execute if data storage datalib:engine schedules run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"schedules","interpret":false,"color":"gold"}]
execute unless data storage datalib:engine schedules run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"text":"(no active schedules)","color":"gray","italic":true}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
