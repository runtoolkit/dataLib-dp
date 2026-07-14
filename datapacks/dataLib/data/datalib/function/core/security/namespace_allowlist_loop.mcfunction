# ======================================================================================
# datalib:core/security/namespace_allowlist_loop
# ======================================================================================
#
# PURPOSE:
#   Tests inputs.func against each prefix in datalib:output _ns.List
#   (populated by input_check Section 5 from datalib:config/namespace_list).
#   Sets #DL.NsPrefixOk dl.tmp to 1 the moment any prefix matches at index 0
#   (i.e. func actually STARTS WITH the prefix, not just contains it
#   somewhere — see string/contains.mcfunction's note on prefix vs contains).
#
# BEHAVIOR:
#   Recurses one list element at a time. Stops early (does not recurse
#   further) once a match is found, since #DL.NsPrefixOk is already 1 and
#   later elements cannot un-set it. If the list is empty or exhausted with
#   no match, #DL.NsPrefixOk stays 0 — fail closed, same as before this
#   file existed.
#
# ISOLATION:
#   Reads/writes only datalib:output _ns and the shared dl.tmp scoreboard
#   scratch objective already used by every other Section in input_check.
#   Does not touch datalib:input, so it cannot be raced by Section 3's
#   snapshot guarantee.
#
# ======================================================================================

# Already matched by an earlier element — stop.
execute if score #DL.NsPrefixOk dl.tmp matches 1 run return 1

# List exhausted — stop, no match found.
execute unless data storage datalib:output _ns.List[0] run return 0

# Test current head element as a prefix of func.
data modify storage stringlib:input find.String set from storage datalib:output inputs.func
data modify storage stringlib:input find.Find set from storage datalib:output _ns.List[0]
function datalib:core/security/string/contains

execute if score #DL.StrIndex dl.tmp matches 0 run scoreboard players set #DL.NsPrefixOk dl.tmp 1

# Drop the tested element, recurse on the rest.
data remove storage datalib:output _ns.List[0]
execute if score #DL.NsPrefixOk dl.tmp matches 0 run function datalib:core/security/namespace_allowlist_loop

return 1
