# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/unregister
# Removes all wand binds belonging to a specific tag.
#
# INPUT:
#   $(tag) → tag to remove
# ─────────────────────────────────────────────────────────────────

execute unless data storage datalib:engine wand_binds run return 0

data modify storage datalib:engine _wand_unbinds set from storage datalib:engine wand_binds
data modify storage datalib:engine wand_binds set value []
$data modify storage datalib:engine _wand_filter_tag set value "$(tag)"
function datalib:core/internal/api/wand/unbind_filter
data remove storage datalib:engine _wand_unbinds
data remove storage datalib:engine _wand_filter_tag
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/unregister ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(tag)","color":"white"},{"text":" removed","color":"#555555"}]
