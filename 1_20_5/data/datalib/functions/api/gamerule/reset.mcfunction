# datalib:api/gamerule/reset [MACRO]
# Removes a custom gamerule from datalib:engine gamerules.
execute unless function datalib:core/security/cmd_gate run return 0
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace
function datalib:core/internal/api/gamerule/remove with storage datalib:input {}
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/reset ","color":"aqua"},{"text":"$(_gamerule_norm)","color":"gray","italic":true},{"text":" removed","color":"gray"}]}
data remove storage datalib:input _gamerule_norm
