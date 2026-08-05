# datalib:api/cb/internal/exec
# Macro: called via "function ... with storage datalib:input cb"
# Expected keys: cmd (string), x (int), y (int), z (int)
#
# Side-effects:
#   • Writes datalib:engine _cb_last {x,y,z} for the cleanup step.
#   • Schedules datalib:api/cb/internal/reset 2t later.

$data modify storage datalib:engine _cb_last set value {x:$(x),y:$(y),z:$(z)}
$forceload add $(x) $(z)
$setblock $(x) $(y) $(z) minecraft:command_block{Command:"",auto:0b,TrackOutput:0b} replace
$data modify block $(x) $(y) $(z) Command set value "$(cmd)"
$data modify block $(x) $(y) $(z) auto set value 1b
schedule function datalib:core/internal/api/cb/reset 2t replace
