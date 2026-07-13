# datalib:api/cmd/other/multi_cmd/internal/cond_tag_simple
# Simple string tag check

data modify storage datalib:engine _mcmd_cond_tmp set value {}
data modify storage datalib:engine _mcmd_cond_tmp.tag set from storage datalib:engine _mcmd_current.condition.tag
function datalib:core/internal/api/cmd/other/multi_cmd/cond_tag_exec with storage datalib:engine _mcmd_cond_tmp
data remove storage datalib:engine _mcmd_cond_tmp
