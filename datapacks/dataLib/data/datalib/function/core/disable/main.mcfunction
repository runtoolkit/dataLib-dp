# Immediate disable (gate removed)
data remove storage datalib:engine
data remove storage datalib:input
scoreboard players set #runtoolkit.packs.datalib.version datalib.meta 0
tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"dataLib disabled.","color":"red"}]
