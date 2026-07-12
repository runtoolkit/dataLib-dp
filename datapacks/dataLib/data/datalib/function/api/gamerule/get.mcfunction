# datalib:api/gamerule/get [MACRO]
# Reads a custom gamerule value from storage into datalib:output gamerule.
#
# INPUT (macro args via `with storage datalib:input {}`):
#   $(rule) — rule name string (must match the name used in set)
#
# OUTPUT:
#   datalib:output gamerule — the stored value string, or absent if never set
#
# EXAMPLE:
#   data modify storage datalib:input rule set value "pvp_enabled"
#   function datalib:api/gamerule/get with storage datalib:input {}
#   # read: data get storage datalib:output gamerule

execute unless function datalib:core/security/cmd_gate run return 0

# Normalize key (spaces → underscores, lowercase)
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace

# Read from engine storage
data remove storage datalib:output gamerule
function datalib:core/internal/api/gamerule/read with storage datalib:input {}

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/get ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"white"},{"text":" = ","color":"#555555"},{"plain":true ,"storage":"datalib:output","nbt":"gamerule","color":"green"}]

data remove storage datalib:input _gamerule_norm
