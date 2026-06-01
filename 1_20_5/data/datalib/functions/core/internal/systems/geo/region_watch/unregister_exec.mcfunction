# datalib:core/internal/systems/geo/region_watch/unregister_exec [MACRO]
# INPUT: $(id)
# region_watches in list format — always run filter,
# if id not found, list remains unchanged.

execute unless data storage datalib:engine region_watches run return 0

data modify storage datalib:engine _rw_unbind_id set from storage datalib:input id
data modify storage datalib:engine _rw_new set value []
data modify storage datalib:engine _rw_src set from storage datalib:engine region_watches
function datalib:core/internal/systems/geo/region_watch/unregister_filter
data modify storage datalib:engine region_watches set from storage datalib:engine _rw_new
data remove storage datalib:engine _rw_new
data remove storage datalib:engine _rw_src
data remove storage datalib:engine _rw_unbind_id

$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo/region_watch/unregister ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" removed","color":"#555555"}]}
