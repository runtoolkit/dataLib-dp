# Immediate disable (gate removed)
datapack disable "file/dataLib.zip"
datapack disable "file/dataLib"
scoreboard players set #runtoolkit.packs.datalib.version datalib.meta 0
tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"dataLib disabled.","color":"red"}]
