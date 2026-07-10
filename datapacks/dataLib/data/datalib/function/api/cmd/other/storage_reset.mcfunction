$data modify storage $(storageName) $(nbt) set value []
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/other/storage_reset ","color":"aqua"},{"text":"$(storageName)","color":"white"},{"text":".","color":"#555555"},{"text":"$(nbt)","color":"aqua"},{"text":" → []","color":"#555555"}]
