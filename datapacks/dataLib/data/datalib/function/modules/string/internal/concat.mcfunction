# datalib:modules/string/internal/concat
# Input:  datalib:input list   — list of strings to concatenate
# Output: datalib:output string.result — combined string
# Dep:    StringLib (CMDred)
data modify storage datalib:stringlib_data.input concat set from storage datalib:input list
function datalib:modules/string/api/legacy/concat
data modify storage datalib:output string.result set from storage datalib:stringlib_data.output concat
data remove storage datalib:stringlib_data.input concat
data remove storage datalib:stringlib_data.output concat
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/concat","color":"aqua"}]
