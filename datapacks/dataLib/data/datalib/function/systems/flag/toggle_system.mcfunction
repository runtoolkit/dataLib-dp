# datalib:systems/flag/toggle_system — Toggle a built-in tick channel on/off
# Usage: function datalib:systems/flag/toggle_system {system:"time"}
# Valid systems: time | queue | player | hud | admin
# Delegates to datalib:core/tick/channel/enable|disable internally.

$data modify storage datalib:tick_work _ftgl set from storage datalib:engine tick.channels[{id:"$(system)_systems"}]
function datalib:systems/flag/toggle_system/exec with storage datalib:tick_work _ftgl