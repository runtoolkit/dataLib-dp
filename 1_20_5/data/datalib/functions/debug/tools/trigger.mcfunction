# datalib:debug/tools/trigger — single-call dispatch layer (EC-style).
# Does not require EventCore; uses AME's own datalib:api/cmd/* functions.
#
# Usage:
# function datalib:debug/tools/trigger {type:"<type>", data:{...}}
# function datalib:debug/tools/trigger {type:"<type>", data:{...}, config:{silent:1}}
#
# config:{silent:1} → suppress debug tellraw.

$data modify storage datalib:engine tools_trigger.type  set value "$(type)"
$data modify storage datalib:engine tools_trigger.data  set value $(data)
$execute unless data storage datalib:engine tools_trigger.config{silent:1} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"tools/trigger ","color":"aqua"},{"text":"► ","color":"yellow"},{"text":"$(type)","color":"white"}]

function datalib:core/internal/debug/tools/trigger/dispatch

data remove storage datalib:engine tools_trigger
