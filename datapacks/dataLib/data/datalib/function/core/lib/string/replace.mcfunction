# datalib:core/lib/string/replace
# Input:  datalib:input string  — original string
#         datalib:input find    — substring to replace
#         datalib:input replace — replacement string
#         datalib:input n       — instance count (0/unset=all, +n=first n, -n=last n)
# Output: datalib:output string.result — resulting string
# Dep:    StringLib (CMDred)
data modify storage stringlib:input replace.String set from storage datalib:input string
data modify storage stringlib:input replace.Find set from storage datalib:input find
data modify storage stringlib:input replace.Replace set from storage datalib:input replace
data remove storage stringlib:input replace.n
data modify storage stringlib:input replace.n set from storage datalib:input n
function stringlib:util/replace
data modify storage datalib:output string.result set from storage stringlib:output replace
data remove storage stringlib:input replace
data remove storage stringlib:output replace
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/replace","color":"aqua"}]
