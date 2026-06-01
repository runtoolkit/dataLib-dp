# datalib:core/internal/systems/hook/on_player_death
# @s = tetikleyen oyuncu
data modify storage datalib:engine _hook_fire_tmp set value {event:"player_death"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
