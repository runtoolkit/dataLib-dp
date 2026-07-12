# datalib:systems/hook/on_drop
# Binds a function or command to the "drop_item" event.
#
# INPUT (storage datalib:input):
#   func → function to run when a player drops an item
#   cmd  → command to run when a player drops an item (used if func is absent)
#
# USAGE:
#   data modify storage datalib:input func set value "mypack:on_drop"
#   function datalib:systems/hook/on_drop
#   -- or --
#   data modify storage datalib:input cmd set value "say An item was dropped"
#   function datalib:systems/hook/on_drop
data modify storage datalib:input event set value "drop_item"
function datalib:systems/hook/bind
