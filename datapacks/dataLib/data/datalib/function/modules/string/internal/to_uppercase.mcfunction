# datalib:modules/string/internal/to_uppercase
# Fast variant — covers a-z only (faster)
# Input:  datalib:input string — string to convert
# Output: datalib:output string.result — uppercase string
# Dep:    StringLib (CMDred)
data modify storage datalib:engine _str_bridge.String set from storage datalib:input string
function datalib:runtime/lib/internal/string/to_upper_fast_dispatch with storage datalib:engine _str_bridge
data modify storage datalib:output string.result set from storage datalib:stringlib_data.output to_uppercase
data remove storage datalib:stringlib_data.output to_uppercase
data remove storage datalib:engine _str_bridge
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_uppercase","color":"aqua"}]
