# datalib:modules/string/internal/split
# Input:  datalib:input string      — original string
#         datalib:input separator   — split delimiter (default " ", ""=each char)
#         datalib:input n           — max splits (0/unset=all, +n=first n, -n=last n)
#         datalib:input keep_empty  — 1b to keep empty segments, omit/0b to strip
# Output: datalib:output string.result — list of string segments
# Dep:    StringLib (CMDred)
data modify storage datalib:stringlib_data.input split.String set from storage datalib:input string
data remove storage datalib:stringlib_data.input split.Separator
data modify storage datalib:stringlib_data.input split.Separator set from storage datalib:input separator
data remove storage datalib:stringlib_data.input split.n
data modify storage datalib:stringlib_data.input split.n set from storage datalib:input n
data remove storage datalib:stringlib_data.input split.KeepEmpty
data modify storage datalib:stringlib_data.input split.KeepEmpty set from storage datalib:input keep_empty
function datalib:modules/string/api/legacy/split
data modify storage datalib:output string.result set from storage datalib:stringlib_data.output split
data remove storage datalib:stringlib_data.input split
data remove storage datalib:stringlib_data.output split
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/split","color":"aqua"}]
