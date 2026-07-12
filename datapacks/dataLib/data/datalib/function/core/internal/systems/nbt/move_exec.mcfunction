# datalib:systems/nbt/internal/move_exec [MACRO]
# INPUT: $(storage), $(from_path), $(to_path)

$data modify storage $(storage) $(to_path) set from storage $(storage) $(from_path)
$data remove storage $(storage) $(from_path)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/move ","color":"aqua"},{"text":"$(from_path)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(to_path)","color":"aqua"}]
