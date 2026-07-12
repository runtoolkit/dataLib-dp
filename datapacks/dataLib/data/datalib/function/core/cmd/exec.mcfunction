# datalib:core/cmd/exec
# Bridges datalib:input cmd → datalib:engine tools_trigger → dispatch.
# Called only when datalib:input cmd exists.

data modify storage datalib:engine tools_trigger set from storage datalib:input cmd
function datalib:core/internal/debug/tools/trigger/dispatch
data remove storage datalib:engine tools_trigger
data remove storage datalib:input cmd
