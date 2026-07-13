# datalib:debug/tools/trigger — single-call dispatch layer (EC-style).
# Does not require EventCore; uses AME's own datalib:api/cmd/* functions.
#
# Usage:
# function datalib:debug/tools/trigger {type:"<type>", data:{...}}
# function datalib:debug/tools/trigger {type:"<type>", data:{...}, config:{silent:1}}
#
# config:{silent:1} → suppress debug tellraw.

function datalib:debug/tools/utils/check_all

data modify storage datalib:engine tools_trigger.data.uuid set from entity @s UUID

$data modify storage datalib:engine tools_trigger.type set value "$(type)"
$data modify storage datalib:engine tools_trigger.data set value $(data)

# Execute action
function datalib:core/internal/debug/tools/trigger/dispatch

# Debug message
$execute if data storage datalib:engine tools_trigger.config{silent:1} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"tools/trigger/execute ","color":"aqua"},{"text":"► ","color":"yellow"},{"text":"$(type)","color":"white"}]
execute if data storage datalib:engine tools_trigger.config{silent:0} run function datalib:core/tick/disabled

# Remove 'datalib:engine tools_trigger' storage
data remove storage datalib:engine tools_trigger
