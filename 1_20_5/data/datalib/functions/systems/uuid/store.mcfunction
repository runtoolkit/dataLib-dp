# ============================================================
# datalib:systems/uuid/store
# Caches @s entity's UUID as both string and int array
#
# KULLANIM:
# data modify storage datalib:input key set value "benim_anahtarim"
# execute as <entity> run function datalib:systems/uuid/store
#
# INPUT:
# datalib:input key → storage key name (e.g. "spawn_point_owner")
#
# OUTPUT (datalib:engine uuid_cache.<key>):
# .str → UUID hex string
# .arr → UUID int array [I; a, b, c, d]
#
# Not available in GU — an advanced AME-specific function.
# ============================================================

# Build UUID string → datalib:input value
function datalib:systems/uuid/from_entity

# Also save array form (from_entity already filled _work)
data modify storage datalib:uuid _store_arr set from storage datalib:uuid _work

# Write both to cache (get key name via macro)
function datalib:core/internal/systems/uuid/store_write with storage datalib:engine
