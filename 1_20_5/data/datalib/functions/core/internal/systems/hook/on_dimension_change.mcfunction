# datalib:core/internal/systems/hook/on_dimension_change
# @s = tetikleyen oyuncu
data modify storage datalib:engine _hook_fire_tmp set value {event:"dimension_change"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
