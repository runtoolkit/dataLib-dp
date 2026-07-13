# datalib:systems/hook/internal/on_drop
data modify storage datalib:engine _hook_fire_tmp set value {event:"drop_item"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
