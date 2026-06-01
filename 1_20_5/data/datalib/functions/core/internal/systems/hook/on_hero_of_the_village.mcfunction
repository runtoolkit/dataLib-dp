# datalib:core/internal/systems/hook/on_hero_of_the_village
# @s = player who triggered the event
data modify storage datalib:engine _hook_fire_tmp set value {event:"hero_of_the_village"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp
