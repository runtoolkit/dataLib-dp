# Module toggle guard — skips this module when disabled via datalib:api/toggle/perm/false
execute unless data storage datalib:engine {modules:{perm:1b}} run return 0

execute unless data storage datalib:engine perm_trigger_names[0] run return 0

data modify storage datalib:engine _pt_names_tmp set from storage datalib:engine perm_trigger_names
function datalib:core/internal/api/perm/trigger/tick_step_loop
data remove storage datalib:engine _pt_names_tmp
