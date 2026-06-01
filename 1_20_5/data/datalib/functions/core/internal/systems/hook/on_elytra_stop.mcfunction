# datalib:core/internal/systems/hook/on_elytra_stop
# @s = player who triggered the event
data modify storage datalib:engine _hook_fire_tmp set value {event:"elytra_stop"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
