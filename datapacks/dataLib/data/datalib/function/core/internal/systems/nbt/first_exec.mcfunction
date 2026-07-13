# datalib:systems/nbt/internal/first_exec [MACRO]
# INPUT: $(src_storage), $(src_path), $(dst_storage), $(dst_path)

$data modify storage $(dst_storage) $(dst_path) set from storage $(src_storage) $(src_path)[0]

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/first ","color":"aqua"},{"text":"$(src_storage):$(src_path)[0]","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(dst_storage):$(dst_path)","color":"aqua"}]
