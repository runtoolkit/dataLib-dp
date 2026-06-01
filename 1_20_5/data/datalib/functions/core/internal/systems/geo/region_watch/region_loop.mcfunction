# datalib:core/internal/systems/geo/region_watch/region_loop
# @s = kontrol edilen oyuncu
# Consumes _rw_iter list, calls check_region for each region.

execute unless data storage datalib:engine _rw_iter[0] run return 0

data modify storage datalib:engine _rw_cur set from storage datalib:engine _rw_iter[0]
data remove storage datalib:engine _rw_iter[0]

function datalib:core/internal/systems/geo/region_watch/check_region with storage datalib:engine _rw_cur

function datalib:core/internal/systems/geo/region_watch/region_loop
