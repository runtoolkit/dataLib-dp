# ============================================================
# datalib:core/internal/systems/uuid/store_write [MACRO FUNCTION]
# UUID'yi datalib:engine uuid_cache'e yazar (hem string hem array)
#
# Call: function datalib:core/internal/systems/uuid/store_write with storage datalib:engine
# $(key)   = key name
# $(value) = UUID hex string (written by from_entity)
# ============================================================
$data modify storage datalib:engine uuid_cache.$(key).str set value "$(value)"
$data modify storage datalib:engine uuid_cache.$(key).arr set from storage datalib:uuid _store_arr
