# datalib:core/tick/channel/set_condition — Set or clear condition predicate
# Usage: function datalib:core/tick/channel/set_condition {id:"channel_id",condition:"ns:pred"}
# function datalib:core/tick/channel/set_condition {id:"channel_id",condition:""} ← always-run
$data modify storage datalib:engine tick.channels[{id:"$(id)"}] merge value {condition:"$(condition)"}