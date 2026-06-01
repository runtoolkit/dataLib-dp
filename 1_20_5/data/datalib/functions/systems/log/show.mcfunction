tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Log Buffer ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━━","color":"#555555"}]}
execute unless data storage datalib:engine log_display[0] run tellraw @s {"text":"","extra":[{"text":" ","color":"#555555"},{"text":"(empty)","color":"gray","italic":true}]}
execute unless data storage datalib:engine log_display[0] run return 0

function datalib:core/lib/input_push
data modify storage datalib:engine _felist_input set from storage datalib:engine log_display
data modify storage datalib:input func set value "datalib:core/internal/systems/log/print_entry"
function datalib:core/lib/for_each_list with storage datalib:engine {}
function datalib:core/lib/input_pop
tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]}
