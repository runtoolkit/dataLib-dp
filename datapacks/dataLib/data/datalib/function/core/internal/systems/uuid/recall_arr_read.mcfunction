# ============================================================
# datalib:systems/uuid/internal/recall_arr_read [MACRO FUNCTION]
# Reads UUID int array from the cache
#
# Call: function datalib:core/internal/systems/uuid/recall_arr_read with storage datalib:input
# $(key) = key name
# ============================================================
$data modify storage datalib:input value set from storage datalib:engine uuid_cache.$(key).arr
