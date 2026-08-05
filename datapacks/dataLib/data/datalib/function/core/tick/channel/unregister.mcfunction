# datalib:core/tick/channel/unregister — Remove a tick channel by ID
# Usage: function datalib:core/tick/channel/unregister {id:"channel_id"}
$data remove storage datalib:engine tick.channels[{id:"$(id)"}]