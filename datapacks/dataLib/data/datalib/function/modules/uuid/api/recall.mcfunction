# ============================================================
# datalib:modules/uuid/api/recall
# Retrieves UUID string from the cache
#
# KULLANIM:
# data modify storage datalib:input key set value "benim_anahtarim"
# function datalib:modules/uuid/api/recall
#
# INPUT:
# datalib:input key → key name used with uuid/store
#
# OUTPUT:
# datalib:input value → UUID hex string
# (value unchanged if key not found)
# ============================================================
function datalib:modules/uuid/internal/recall_read with storage datalib:input
