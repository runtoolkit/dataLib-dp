tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Player States ","color":"aqua"},{"text":"━━━━━━━━━━","color":"#555555"}]
execute if data storage datalib:engine states run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"states","interpret":false,"color":"white"}]
execute unless data storage datalib:engine states run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"text":"(no active states)","color":"gray","italic":true}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
