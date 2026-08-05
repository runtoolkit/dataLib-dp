# datalib:api/wand/internal/register_fn_do [MACRO] [INTERNAL]
# Called by wand/register_fn with storage datalib:input {} to do the actual append.
# INPUT: $(tag), $(func)
$data modify storage datalib:engine wand_binds append value {tag:"$(tag)", func:"$(func)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/register_fn ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"},{"text":" → func","color":"#555555"}]
