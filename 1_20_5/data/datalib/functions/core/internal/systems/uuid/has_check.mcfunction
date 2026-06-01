# ============================================================
# datalib:core/internal/systems/uuid/has_check [MACRO FUNCTION]
# Checks key existence in the cache
#
# Call: function datalib:core/internal/systems/uuid/has_check with storage datalib:engine
# $(key) = name of the key to check
# ============================================================
$execute if data storage datalib:engine uuid_cache.$(key) run scoreboard players set $uuid.has dl.tmp 1
