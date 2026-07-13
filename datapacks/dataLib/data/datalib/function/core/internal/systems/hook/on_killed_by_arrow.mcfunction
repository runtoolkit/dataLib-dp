# datalib:systems/hook/internal/on_killed_by_arrow
# @s = player who triggered the event
data modify storage datalib:engine _hook_fire_tmp set value {event:"killed_by_arrow"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
