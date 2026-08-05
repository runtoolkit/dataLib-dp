# datalib:systems/hook/internal/on_level_up
# @s = the triggering player
data modify storage datalib:engine _hook_fire_tmp set value {event:"level_up"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
