# ============================================================
# datalib:systems/uuid/recall
# Retrieves UUID string from the cache
#
# KULLANIM:
# data modify storage datalib:input key set value "benim_anahtarim"
# function datalib:systems/uuid/recall
#
# INPUT:
# datalib:input key → key name used with uuid/store
#
# OUTPUT:
# datalib:input value → UUID hex string
# (value unchanged if key not found)
# ============================================================
function datalib:core/internal/systems/uuid/recall_read with storage datalib:input
