# datalib:systems/hook/internal/on_fish_fire
# @s = the fishing player
data modify storage datalib:engine _hook_fire_tmp set value {event:"fish_caught"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
