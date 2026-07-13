execute unless function datalib:debug/tools/utils/check_all run return 0

$loot spawn $(x) $(y) $(z) loot $(loot_table)
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/loot_drop ","color":"aqua"}]
