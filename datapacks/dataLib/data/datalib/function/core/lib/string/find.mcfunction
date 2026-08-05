# datalib:core/lib/string/find
# Input:  datalib:input string  — haystack string
#         datalib:input find    — substring to search
#         datalib:input n       — instance count (0=all, +n=first n, -n=last n)
# Output: datalib:output string.result — list of start indices, or [-1] if not found
# Dep:    StringLib (CMDred)
data modify storage stringlib:input find.String set from storage datalib:input string
data modify storage stringlib:input find.Find set from storage datalib:input find
data remove storage stringlib:input find.n
data modify storage stringlib:input find.n set from storage datalib:input n
function stringlib:util/find
data modify storage datalib:output string.result set from storage stringlib:output find
data remove storage stringlib:input find
data remove storage stringlib:output find
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/find","color":"aqua"}]
