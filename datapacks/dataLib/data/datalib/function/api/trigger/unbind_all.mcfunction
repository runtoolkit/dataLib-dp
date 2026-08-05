data modify storage datalib:engine trigger_binds set value []
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"trigger/unbind_all ","color":"aqua"},{"text":"⚠ ","color":"yellow"},{"text":"all trigger binds cleared","color":"#555555"}]
