# datalib:systems/hook/on_player_death
# Reward: player_death advancement (entity_killed_player trigger)
# @s = dying player
advancement revoke @s only datalib:systems/hook/player_death
data modify storage datalib:engine _hook_fire_tmp set value {event:"player_death"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
