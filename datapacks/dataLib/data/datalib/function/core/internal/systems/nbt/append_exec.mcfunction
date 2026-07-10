# datalib:systems/nbt/internal/append_exec [MACRO]
# INPUT: $(dst_storage), $(dst_path), $(src_storage), $(src_path)

$data modify storage $(dst_storage) $(dst_path) append from storage $(src_storage) $(src_path)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/append ","color":"aqua"},{"text":"$(src_storage):$(src_path)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(dst_storage):$(dst_path)","color":"aqua"}]
