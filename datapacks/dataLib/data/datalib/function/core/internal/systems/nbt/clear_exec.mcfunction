# datalib:systems/nbt/internal/clear_exec [MACRO]
# INPUT: $(storage), $(path)

$data remove storage $(storage) $(path)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/clear ","color":"aqua"},{"text":"$(storage):$(path)","color":"white"}]
