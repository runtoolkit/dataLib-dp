# datalib:core/tick/channel/disable — Disable a tick channel by ID
# Usage: function datalib:core/tick/channel/disable {id:"channel_id"}
$data modify storage datalib:engine tick.channels[{id:"$(id)"}] merge value {enabled:0b}