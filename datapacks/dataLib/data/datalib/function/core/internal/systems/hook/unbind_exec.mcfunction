# datalib:systems/hook/internal/unbind_exec [MACRO]
# INPUT: $(event)
# Filters all binds belonging to $(event) from hook_binds.

data modify storage datalib:engine _hook_unbinds set from storage datalib:engine hook_binds
data modify storage datalib:engine hook_binds set value []
$data modify storage datalib:engine _hook_filter_event set value "$(event)"
function datalib:core/internal/systems/hook/unbind_filter

data remove storage datalib:engine _hook_unbinds
data remove storage datalib:engine _hook_filter_event

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"hook/unbind ","color":"aqua"},{"text":"$(event)","color":"yellow"},{"text":" removed","color":"#555555"}]
