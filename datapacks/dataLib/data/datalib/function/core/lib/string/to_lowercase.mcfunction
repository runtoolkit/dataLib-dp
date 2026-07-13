# datalib:core/lib/string/to_lowercase
# Fast variant — covers A-Z only (faster)
# Input:  datalib:input string — string to convert
# Output: datalib:output string.result — lowercase string
# Dep:    StringLib (CMDred)
data modify storage datalib:engine _str_bridge.String set from storage datalib:input string
function datalib:core/internal/core/lib/string/to_lower_fast_dispatch with storage datalib:engine _str_bridge
data modify storage datalib:output string.result set from storage stringlib:output to_lowercase
data remove storage stringlib:output to_lowercase
data remove storage datalib:engine _str_bridge
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_lowercase","color":"aqua"}]
