# Tag object checker - {name:"...", has:1b/0b}

data modify storage datalib:engine _mcmd_cond_tmp set from storage datalib:engine _mcmd_current.condition.tag
execute unless data storage datalib:engine _mcmd_cond_tmp.has run data modify storage datalib:engine _mcmd_cond_tmp.has set value 1b

function datalib:core/internal/api/cmd/other/multi_cmd/cond_tag_obj_exec with storage datalib:engine _mcmd_cond_tmp
data remove storage datalib:engine _mcmd_cond_tmp
