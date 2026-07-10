# datalib:api/wand/unregister_all — Clears all wand binds.
data modify storage datalib:engine wand_binds set value []
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/unregister_all ","color":"aqua"},{"text":"⚠ all wand binds cleared","color":"yellow"}]
