# datalib:core/internal/systems/geo/region_watch/tick_scan
# Called from hook/internal/tick_scan (requires patch).
# If region_watches is non-empty, checks all regions for each player.

execute unless data storage datalib:engine region_watches run return 0

data modify storage datalib:engine _rw_watch_list set from storage datalib:engine region_watches
execute as @a run function datalib:core/internal/systems/geo/region_watch/player_scan
data remove storage datalib:engine _rw_watch_list
