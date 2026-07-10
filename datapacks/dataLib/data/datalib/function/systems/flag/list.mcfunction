tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Global Flags ","color":"aqua"},{"text":"━━━━━━━━━━━","color":"#555555"}]
execute if data storage datalib:engine flags run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"flags","interpret":false,"color":"white"}]
execute unless data storage datalib:engine flags run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"text":"(no active flags)","color":"gray","italic":true}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
