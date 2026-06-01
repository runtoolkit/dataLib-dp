# datalib:core/lib/string/insert
# Input:  datalib:input string    — original string
#         datalib:input insertion — string to insert
#         datalib:input index     — insertion position (integer)
# Output: datalib:output string.result — resulting string
# Dep:    StringLib (CMDred)
data modify storage stringlib:input insert.String set from storage datalib:input string
data modify storage stringlib:input insert.Insertion set from storage datalib:input insertion
data modify storage datalib:engine _str_bridge.Index set from storage datalib:input index
function datalib:core/internal/lib/string/insert_dispatch with storage datalib:engine _str_bridge
data modify storage datalib:output string.result set from storage stringlib:output insert
data remove storage stringlib:input insert
data remove storage stringlib:output insert
data remove storage datalib:engine _str_bridge
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/insert","color":"aqua"}]
