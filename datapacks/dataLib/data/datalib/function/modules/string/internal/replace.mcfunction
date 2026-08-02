# datalib:modules/string/internal/replace
# Input:  datalib:input string  — original string
#         datalib:input find    — substring to replace
#         datalib:input replace — replacement string
#         datalib:input n       — instance count (0/unset=all, +n=first n, -n=last n)
# Output: datalib:output string.result — resulting string
# Dep:    StringLib (CMDred)
data modify storage datalib:stringlib_data.input replace.String set from storage datalib:input string
data modify storage datalib:stringlib_data.input replace.Find set from storage datalib:input find
data modify storage datalib:stringlib_data.input replace.Replace set from storage datalib:input replace
data remove storage datalib:stringlib_data.input replace.n
data modify storage datalib:stringlib_data.input replace.n set from storage datalib:input n
function datalib:modules/string/api/legacy/replace
data modify storage datalib:output string.result set from storage datalib:stringlib_data.output replace
data remove storage datalib:stringlib_data.input replace
data remove storage datalib:stringlib_data.output replace
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/string/replace","color":"aqua"}]
