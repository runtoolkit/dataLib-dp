$execute unless data storage datalib:engine perm_triggers.$(name) run return 0

$data modify storage datalib:engine _pt_unbind set from storage datalib:engine perm_triggers.$(name)
$data modify storage datalib:engine perm_triggers.$(name) set value []
$data modify storage datalib:engine _pt_uval set value $(value)
$data modify storage datalib:engine _pt_filter_ctx set value {name:"$(name)"}

function datalib:core/internal/api/perm/trigger/unbind_filter

data remove storage datalib:engine _pt_unbind
data remove storage datalib:engine _pt_uval
data remove storage datalib:engine _pt_filter_ctx
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm/trigger/unbind ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(name)","color":"white"},{"text":":","color":"#555555"},{"text":"$(value)","color":"yellow"},{"text":" removed","color":"#555555"}]
