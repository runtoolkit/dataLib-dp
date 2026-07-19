# ============================================================
# datalib:systems/uuid/cache_clear
# Clears all cache (all entries saved with uuid/store)
#
# KULLANIM:
# function datalib:systems/uuid/cache_clear
#
# Warning: This operation is irreversible. All stored UUIDs are deleted.
# Typically used when resetting the world or when a player leaves.
# ============================================================
data modify storage datalib:engine uuid_cache set value {}
