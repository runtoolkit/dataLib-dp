# datalib:core/lib/string/concat
# Input:  datalib:input list   — list of strings to concatenate
# Output: datalib:output string.result — combined string
# Dep:    StringLib (CMDred)
data modify storage stringlib:input concat set from storage datalib:input list
function stringlib:util/concat
data modify storage datalib:output string.result set from storage stringlib:output concat
data remove storage stringlib:input concat
data remove storage stringlib:output concat
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/concat","color":"aqua"}]
