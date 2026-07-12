# ============================================================
# datalib:systems/uuid/recall_array
# Retrieves UUID int array from the cache
#
# KULLANIM:
# data modify storage datalib:input key set value "benim_anahtarim"
# function datalib:systems/uuid/recall_array
#
# INPUT:
# datalib:input key → key name used with uuid/store
#
# OUTPUT:
# datalib:input value → UUID int array [I; a, b, c, d]
# (value unchanged if key not found)
#
# Use case: writing UUID to entity NBT (e.g. Owner field)
# ============================================================
function datalib:core/internal/systems/uuid/recall_arr_read with storage datalib:input
