data modify storage datalib:engine global.version set value "v6.0.2"

scoreboard players set #runtoolkit.packs.datalib.version datalib.meta 602

tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"dataLib v6.0.2 loaded.","color":"green"}]
