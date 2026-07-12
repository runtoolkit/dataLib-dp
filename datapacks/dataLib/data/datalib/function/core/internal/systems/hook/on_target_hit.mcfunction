# datalib:systems/hook/internal/on_target_hit
data modify storage datalib:engine _hook_fire_tmp set value {event:"target_hit"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
