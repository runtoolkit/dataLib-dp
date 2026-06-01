# datalib:core/lib/string/to_lowercase_full
# Full variant — covers full Unicode uppercase mapping (slower)
# Input:  datalib:input string — string to convert
# Output: datalib:output string.result — lowercase string
# Dep:    StringLib (CMDred)
data modify storage datalib:engine _str_bridge.String set from storage datalib:input string
function datalib:core/internal/lib/string/to_lower_full_dispatch with storage datalib:engine _str_bridge
data modify storage datalib:output string.result set from storage stringlib:output to_lowercase
data remove storage stringlib:output to_lowercase
data remove storage datalib:engine _str_bridge
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_lowercase_full","color":"aqua"}]
