# datalib:systems/hook/internal/on_open_chest
data modify storage datalib:engine _hook_fire_tmp set value {event:"open_chest"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
