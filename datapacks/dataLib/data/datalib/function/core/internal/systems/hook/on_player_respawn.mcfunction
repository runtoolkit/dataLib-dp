# datalib:systems/hook/internal/on_player_respawn
# @s = the triggering player
data modify storage datalib:engine _hook_fire_tmp set value {event:"player_respawn"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp

# Event bus
function #datalib:events/on_respawn
