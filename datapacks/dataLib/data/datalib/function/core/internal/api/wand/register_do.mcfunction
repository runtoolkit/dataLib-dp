# datalib:api/wand/internal/register_do [MACRO] [INTERNAL]
# Called by wand/register with storage datalib:input {} to do the actual append.
# INPUT: $(tag), $(func), $(cmd)
$data modify storage datalib:engine wand_binds append value {tag:"$(tag)", func:"$(func)", cmd:"$(cmd)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/register ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"}]
