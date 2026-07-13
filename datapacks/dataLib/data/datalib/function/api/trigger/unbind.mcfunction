execute unless data storage datalib:engine trigger_binds run return 0

data modify storage datalib:engine _tc_unbind set from storage datalib:engine trigger_binds
data modify storage datalib:engine trigger_binds set value []

$data modify storage datalib:engine _tc_uval set value $(value)
function datalib:core/internal/api/trigger/unbind_filter
data remove storage datalib:engine _tc_unbind
data remove storage datalib:engine _tc_uval
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"trigger/unbind ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"value=$(value)","color":"white"},{"text":" removed","color":"#555555"}]
