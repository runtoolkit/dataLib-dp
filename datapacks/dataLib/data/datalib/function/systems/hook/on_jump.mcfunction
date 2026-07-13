# datalib:systems/hook/on_jump
# Binds a function or command to the "jumped" event.
#
# INPUT (storage datalib:input):
#   func → function to run when a player jumps
#   cmd  → command to run when a player jumps (used if func is absent)
#
# USAGE:
#   data modify storage datalib:input func set value "mypack:on_jump"
#   function datalib:systems/hook/on_jump
#   -- or --
#   data modify storage datalib:input cmd set value "say A player jumped"
#   function datalib:systems/hook/on_jump
data modify storage datalib:input event set value "jumped"
function datalib:systems/hook/bind
