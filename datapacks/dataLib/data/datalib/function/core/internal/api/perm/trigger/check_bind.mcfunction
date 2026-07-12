execute unless data storage datalib:engine _ptd_binds[0] run return 0

data modify storage datalib:engine _ptd_current set from storage datalib:engine _ptd_binds[0]
data remove storage datalib:engine _ptd_binds[0]

execute store result score $ptd_entry_val dl.tmp run data get storage datalib:engine _ptd_current.value
execute if score $ptd_val dl.tmp = $ptd_entry_val dl.tmp run function datalib:core/internal/api/perm/trigger/run_if_perm with storage datalib:engine _ptd_current

function datalib:core/internal/api/perm/trigger/check_bind
