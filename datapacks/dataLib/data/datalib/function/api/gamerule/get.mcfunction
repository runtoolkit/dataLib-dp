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
data modify storage stringlib:input to_lowercase.String set from storage stringlib:output replace
data remove storage stringlib:input replace
function stringlib:util/to_lowercase/fast
data modify storage datalib:input _gamerule_norm set from storage stringlib:output to_lowercase

# Read from engine storage
data remove storage datalib:output gamerule
function datalib:core/internal/api/gamerule/read with storage datalib:input {}

# $(_gamerule_norm) below is a NEW macro invocation's arg, bound at call time
# from current storage — NOT the same binding as this function's own $(rule)
# arg (which was fixed at entry, before _gamerule_norm existed). Calling this
# inline as a bare $tellraw would have silently failed to resolve.
function datalib:core/internal/api/gamerule/debug_print with storage datalib:input {}

data remove storage datalib:input _gamerule_norm
