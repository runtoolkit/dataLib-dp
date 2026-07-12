execute unless data storage datalib:engine _tc_unbind[0] run return 0

execute store result score $tc_fval dl.tmp run data get storage datalib:engine _tc_unbind[0].value

execute store result score $tc_uval dl.tmp run data get storage datalib:engine _tc_uval

execute unless score $tc_fval dl.tmp = $tc_uval dl.tmp run data modify storage datalib:engine trigger_binds append from storage datalib:engine _tc_unbind[0]

data remove storage datalib:engine _tc_unbind[0]
function datalib:core/internal/api/trigger/unbind_filter
