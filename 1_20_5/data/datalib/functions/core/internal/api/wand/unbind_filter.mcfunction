# datalib:core/internal/api/wand/unbind_filter
# Write back entries from _wand_unbinds that do not match _wand_filter_tag.

execute unless data storage datalib:engine _wand_unbinds[0] run return 0

data modify storage datalib:engine _wand_cur set from storage datalib:engine _wand_unbinds[0]
data remove storage datalib:engine _wand_unbinds[0]

function datalib:core/internal/api/wand/unbind_check with storage datalib:engine _wand_cur

function datalib:core/internal/api/wand/unbind_filter
data remove storage datalib:engine _wand_cur
