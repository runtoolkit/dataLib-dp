execute unless data storage datalib:engine _pt_unbind[0] run return 0

execute store result score $pt_fval dl.tmp run data get storage datalib:engine _pt_unbind[0].value
execute store result score $pt_uval dl.tmp run data get storage datalib:engine _pt_uval

execute unless score $pt_fval dl.tmp = $pt_uval dl.tmp run function datalib:core/internal/api/perm/trigger/unbind_reinsert with storage datalib:engine _pt_filter_ctx

data remove storage datalib:engine _pt_unbind[0]
function datalib:core/internal/api/perm/trigger/unbind_filter
