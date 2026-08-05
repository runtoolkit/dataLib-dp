execute unless data storage datalib:engine _mcmd_list[0] run return 0

data modify storage datalib:engine _mcmd_entry set value {}
data modify storage datalib:engine _mcmd_entry.current_cmd set from storage datalib:engine _mcmd_list[0]
data remove storage datalib:engine _mcmd_list[0]

function datalib:core/internal/api/cmd/other/multi_cmd/exec_func with storage datalib:engine _mcmd_entry

function datalib:core/internal/api/cmd/other/multi_cmd/step_func
