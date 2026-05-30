execute unless data storage datalib:engine log_display[0] run tellraw @s {"text":"[Log] No entries.","color":"gray","italic":false}
execute unless data storage datalib:engine log_display[0] run return 0

function datalib:core/lib/input_push
data modify storage datalib:engine _felist_input set from storage datalib:engine log_display
data modify storage datalib:input func set value "datalib:systems/log/internal/print_entry"
function datalib:core/lib/for_each_list with storage datalib:input {}
function datalib:core/lib/input_pop
