# datalib:core/lib/string/to_number
# Input:  datalib:input string — numeric string (e.g. "42" or "3.14")
# Output: datalib:output string.result — numeric NBT value
# Dep:    StringLib (CMDred)
data modify storage datalib:engine _str_bridge.Input set from storage datalib:input string
function datalib:core/internal/core/lib/string/to_number_dispatch with storage datalib:engine _str_bridge
data modify storage datalib:output string.result set from storage stringlib:output to_number
data remove storage stringlib:output to_number
data remove storage datalib:engine _str_bridge
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_number","color":"aqua"}]
