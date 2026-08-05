# dependencies — StringLib optional warn only
execute unless score #StringLib.Init StringLib matches 1 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"StringLib not initialized (optional).","color":"yellow"}]
