# datalib:systems/geo/region_watch/internal/unregister_filter
# Iterates _rw_src list.
# Copies entries whose id does not match _rw_unbind_id to _rw_new.

execute unless data storage datalib:engine _rw_src[0] run return 0

data modify storage datalib:engine _rw_cur set from storage datalib:engine _rw_src[0]
data remove storage datalib:engine _rw_src[0]

function datalib:internal/geo/region_watch/unregister_check with storage datalib:engine _rw_cur

function datalib:internal/geo/region_watch/unregister_filter