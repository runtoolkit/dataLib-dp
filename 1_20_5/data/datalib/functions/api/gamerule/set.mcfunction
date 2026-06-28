# datalib:api/gamerule/set [MACRO]
# Sets a custom gamerule value in datalib:engine gamerules.<rule>.
# INPUT: data modify storage datalib:input rule set value "pvp_enabled"
#        data modify storage datalib:input value set value "true"
# OPTIONAL: gr_on_true, gr_on_false, gr_on_value, gr_matches

execute unless function datalib:core/security/cmd_gate run return 0
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace
function datalib:core/internal/api/gamerule/persist with storage datalib:input {}
function datalib:core/internal/api/gamerule/dispatch with storage datalib:input {}
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/set ","color":"aqua"},{"text":"$(_gamerule_norm)","color":"white"},{"text":" = ","color":"#555555"},{"text":"$(value)","color":"green"}]}
data remove storage datalib:input _gamerule_norm
return 1
