# datalib:systems/hook/on_eat
# Binds a function or command to the "eat" event.
#
# INPUT (storage datalib:input):
#   func → function to run when a player eats
#   cmd  → command to run when a player eats (used if func is absent)
#
# USAGE:
#   data modify storage datalib:input func set value "mypack:on_eat"
#   function datalib:systems/hook/on_eat
#   -- or --
#   data modify storage datalib:input cmd set value "say I ate something"
#   function datalib:systems/hook/on_eat
data modify storage datalib:input event set value "eat"
function datalib:systems/hook/bind
