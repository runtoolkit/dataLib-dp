execute unless data storage datalib:engine _tc_binds[0] run return 0

data modify storage datalib:engine _tc_current set from storage datalib:engine _tc_binds[0]
data remove storage datalib:engine _tc_binds[0]

execute store result score $tc_val dl.tmp run data get storage datalib:engine _tc_current.value

execute if score $tc_player dl.tmp = $tc_val dl.tmp if data storage datalib:engine _tc_current.func run function datalib:core/internal/api/trigger/call with storage datalib:engine _tc_current

execute if score $tc_player dl.tmp = $tc_val dl.tmp if data storage datalib:engine _tc_current.cmd run function datalib:core/internal/api/trigger/call2 with storage datalib:engine _tc_current

function datalib:core/internal/api/trigger/check_next
