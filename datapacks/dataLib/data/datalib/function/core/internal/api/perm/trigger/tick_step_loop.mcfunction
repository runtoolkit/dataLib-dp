execute unless data storage datalib:engine _pt_names_tmp[0] run return 0

data modify storage datalib:engine _pt_tick_ctx set from storage datalib:engine _pt_names_tmp[0]
data remove storage datalib:engine _pt_names_tmp[0]

function datalib:core/internal/api/perm/trigger/tick_dispatch with storage datalib:engine _pt_tick_ctx

function datalib:core/internal/api/perm/trigger/tick_step_loop
