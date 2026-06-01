# datalib:core/internal/api/wand/register_fn_do [MACRO] [INTERNAL] [1.20.5]
$data modify storage datalib:engine wand_binds append value {tag:"$(tag)", func:"$(func)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/register_fn ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"},{"text":" → func","color":"#555555"}]
