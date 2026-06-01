# datalib:core/internal/systems/hook/on_eat_fire
# @s = yiyen oyuncu
data modify storage datalib:engine _hook_fire_tmp set value {event:"eat"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
