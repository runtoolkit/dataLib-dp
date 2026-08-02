# datalib:systems/nbt/internal/merge_exec [MACRO]
# INPUT: $(src_storage), $(src_path), $(dst_storage), $(dst_path)

$data modify storage $(dst_storage) $(dst_path) merge from storage $(src_storage) $(src_path)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/merge ","color":"aqua"},{"text":"$(src_storage):$(src_path)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(dst_storage):$(dst_path)","color":"aqua"}]
