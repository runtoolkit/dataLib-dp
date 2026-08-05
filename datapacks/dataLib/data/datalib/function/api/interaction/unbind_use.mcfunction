execute unless data storage datalib:engine interaction_binds.use[0] run return 0

data modify storage datalib:engine _ia_ubinds set from storage datalib:engine interaction_binds.use
data modify storage datalib:engine interaction_binds.use set value []
$data modify storage datalib:engine _ia_ufilter set value {tag:"$(tag)", func:"$(func)", list:"use"}
function datalib:core/internal/api/interaction/unbind_filter
data remove storage datalib:engine _ia_ubinds
data remove storage datalib:engine _ia_ufilter

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"interaction/unbind_use ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(tag)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
