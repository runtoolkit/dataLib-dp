# datalib:api/wand/internal/register_cmd_do [MACRO] [INTERNAL]
# Called by wand/register_cmd with storage datalib:input {} to do the actual append.
# INPUT: $(tag), $(cmd)
$data modify storage datalib:engine wand_binds append value {tag:"$(tag)", cmd:"$(cmd)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/register_cmd ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"},{"text":" → cmd","color":"#555555"}]
