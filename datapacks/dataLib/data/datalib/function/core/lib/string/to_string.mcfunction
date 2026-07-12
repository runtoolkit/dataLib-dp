# datalib:core/lib/string/to_string
# Input:  datalib:input value — numeric or any SNBT value to stringify
# Output: datalib:output string.result — string representation
# Note:   Prefer 'data modify ... set string storage ...' when possible (cheaper)
# Dep:    StringLib (CMDred)
data modify storage datalib:engine _str_bridge.Input set from storage datalib:input value
function datalib:core/internal/core/lib/string/to_string_dispatch with storage datalib:engine _str_bridge
data modify storage datalib:output string.result set from storage stringlib:output to_string
data remove storage stringlib:output to_string
data remove storage datalib:engine _str_bridge
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_string","color":"aqua"}]
