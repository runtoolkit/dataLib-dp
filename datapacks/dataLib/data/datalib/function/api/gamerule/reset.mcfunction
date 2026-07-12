# datalib:api/gamerule/reset [MACRO]
# Removes a custom gamerule from engine storage entirely.
# Does NOT touch vanilla /gamerule — this is for datalib-tracked rules only.
#
# INPUT (macro args via `with storage datalib:input {}`):
#   $(rule) — rule name string
#
# EXAMPLE:
#   data modify storage datalib:input rule set value "pvp_enabled"
#   function datalib:api/gamerule/reset with storage datalib:input {}

execute unless function datalib:core/security/cmd_gate run return 0

# Normalize
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace

function datalib:core/internal/api/gamerule/remove with storage datalib:input {}

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/reset ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"gray","italic":true},{"text":" removed","color":"gray"}]

data remove storage datalib:input _gamerule_norm
