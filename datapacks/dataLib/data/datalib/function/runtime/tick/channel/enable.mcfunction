# datalib:runtime/tick/channel/enable — Enable a tick channel by ID
# Usage: function datalib:runtime/tick/channel/enable {id:"channel_id"}
$data modify storage datalib:engine tick.channels[{id:"$(id)"}] merge value {enabled:1b}