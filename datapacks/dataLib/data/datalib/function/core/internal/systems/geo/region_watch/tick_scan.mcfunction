# datalib:systems/geo/region_watch/internal/tick_scan
# Called directly from core/tick/queue_systems.mcfunction.
# If region_watches is non-empty, checks all regions for each player.

# Module toggle guard — skips this module when disabled via datalib:api/toggle/geo/false
execute unless data storage datalib:engine {modules:{geo:1b}} run return 0

execute unless data storage datalib:engine region_watches run return 0

data modify storage datalib:engine _rw_watch_list set from storage datalib:engine region_watches
execute as @a run function datalib:core/internal/systems/geo/region_watch/player_scan
data remove storage datalib:engine _rw_watch_list
