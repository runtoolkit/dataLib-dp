# datalib:api/gamerule/get [MACRO]
# Reads a custom gamerule from datalib:engine gamerules.<rule>.
# INPUT: data modify storage datalib:input rule set value "pvp_enabled"
# CALL:  function datalib:api/gamerule/get with storage datalib:input {}
# OUT:   datalib:output gamerule

execute unless function datalib:core/security/cmd_gate run return 0
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace
data remove storage datalib:output gamerule
function datalib:core/internal/api/gamerule/read with storage datalib:input {}
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/get ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"white"}]}
data remove storage datalib:input _gamerule_norm
