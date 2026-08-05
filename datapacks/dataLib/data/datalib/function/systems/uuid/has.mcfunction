# ============================================================
# datalib:systems/uuid/has
# Checks whether the specified key exists in the cache
#
# EXAMPLE:
# data modify storage datalib:input key set value "my_key"
# execute if score $result dl.tmp matches 1 ...
# function datalib:systems/uuid/has
#
# INPUT:
# datalib:input key → name of the key to check
#
# OUTPUT:
# $uuid.has dl.tmp → 1 (found) or 0 (not found)
# ============================================================
scoreboard players set $uuid.has dl.tmp 0
function datalib:core/internal/systems/uuid/has_check with storage datalib:input
