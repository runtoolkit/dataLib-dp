# Convert string list to {func:"..."} objects
execute unless data storage datalib:input list[0] run return 0

data modify storage datalib:engine _mcmd_func_tmp set value {}
data modify storage datalib:engine _mcmd_func_tmp.func set from storage datalib:input list[0]
data modify storage datalib:engine _mcmd_queue append from storage datalib:engine _mcmd_func_tmp

data remove storage datalib:input list[0]
function datalib:core/internal/api/cmd/other/multi_cmd/func_convert_loop
