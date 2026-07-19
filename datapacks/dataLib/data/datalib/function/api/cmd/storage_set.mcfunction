execute unless function datalib:debug/tools/utils/check_all run return 0

$data modify storage $(storage) $(nbt) set $(actionType) $(value)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/storage_set ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(value)","color":"aqua"}]
