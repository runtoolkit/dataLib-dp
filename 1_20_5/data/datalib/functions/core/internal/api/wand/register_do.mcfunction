# datalib:core/internal/api/wand/register_do [MACRO] [INTERNAL] [1.20.5]
$data modify storage datalib:engine wand_binds append value {tag:"$(tag)", func:"$(func)", cmd:"$(cmd)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/register ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"}]
