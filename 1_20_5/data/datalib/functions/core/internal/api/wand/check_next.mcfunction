# datalib:core/internal/api/wand/check_next
# Iterate bind list: match the tag of the held item.

execute unless data storage datalib:engine _wand_iter[0] run return 0

data modify storage datalib:engine _wand_current set from storage datalib:engine _wand_iter[0]
data remove storage datalib:engine _wand_iter[0]

function datalib:core/internal/api/wand/check_item with storage datalib:engine _wand_current

function datalib:core/internal/api/wand/check_next
