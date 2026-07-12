# datalib:systems/hook/on_target_hit
# Binds a function or command to the "target_hit" event.
#
# INPUT (storage datalib:input):
#   func → function to run when a player hits a target block
#   cmd  → command to run when a player hits a target block (used if func is absent)
#
# USAGE:
#   data modify storage datalib:input func set value "mypack:on_target_hit"
#   function datalib:systems/hook/on_target_hit
#   -- or --
#   data modify storage datalib:input cmd set value "say Target hit"
#   function datalib:systems/hook/on_target_hit
data modify storage datalib:input event set value "target_hit"
function datalib:systems/hook/bind
