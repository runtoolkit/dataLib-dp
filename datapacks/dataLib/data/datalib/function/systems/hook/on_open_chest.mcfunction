# datalib:systems/hook/on_open_chest
# Binds a function or command to the "open_chest" event.
#
# INPUT (storage datalib:input):
#   func → function to run when a player opens a chest
#   cmd  → command to run when a player opens a chest (used if func is absent)
#
# USAGE:
#   data modify storage datalib:input func set value "mypack:on_open_chest"
#   function datalib:systems/hook/on_open_chest
#   -- or --
#   data modify storage datalib:input cmd set value "say A chest was opened"
#   function datalib:systems/hook/on_open_chest
data modify storage datalib:input event set value "open_chest"
function datalib:systems/hook/bind
