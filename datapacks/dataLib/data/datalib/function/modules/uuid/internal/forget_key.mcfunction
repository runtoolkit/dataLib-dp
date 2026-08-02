# ============================================================
# datalib:systems/uuid/internal/forget_key [MACRO FUNCTION]
# Deletes the specified key from uuid_cache
#
# Call: function datalib:modules/uuid/internal/forget_key with storage datalib:input
# $(key) = name of the key to delete
# ============================================================
$data remove storage datalib:engine uuid_cache.$(key)
