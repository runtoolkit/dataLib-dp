# datalib:systems/nbt/internal/swap_exec [MACRO]
# INPUT: $(storage), $(path_a), $(path_b)

$data modify storage datalib:engine _nbt_swap set from storage $(storage) $(path_a)
$data modify storage $(storage) $(path_a) set from storage $(storage) $(path_b)
$data modify storage $(storage) $(path_b) set from storage datalib:engine _nbt_swap
data remove storage datalib:engine _nbt_swap

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/swap ","color":"aqua"},{"text":"$(path_a)","color":"white"},{"text":" ↔ ","color":"#555555"},{"text":"$(path_b)","color":"aqua"}]
