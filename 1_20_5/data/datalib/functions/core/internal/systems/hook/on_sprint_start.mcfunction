# datalib:core/internal/systems/hook/on_sprint_start
# @s = player who triggered the event
data modify storage datalib:engine _hook_fire_tmp set value {event:"sprint_start"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
