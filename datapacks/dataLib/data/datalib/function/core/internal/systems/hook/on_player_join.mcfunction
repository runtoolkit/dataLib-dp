# datalib:systems/hook/internal/on_player_join
# @s = the triggering player
data modify storage datalib:engine _hook_fire_tmp set value {event:"player_join"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp

# Event bus
function #datalib:events/on_join

# Initialize player data and assign datalib.pid
# get_name populates datalib:names temp.NAME; init_from_name relays it to player/init
function datalib:player/get_name
function datalib:core/internal/player/init_from_name with storage datalib:names temp
