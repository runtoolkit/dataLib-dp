$data modify storage datalib:engine event_context.player set value "$(player)"

function datalib:events/fire with storage datalib:input {}

data remove storage datalib:engine event_context.player

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"event/fire_as ","color":"aqua"},{"text":"$(event)","color":"aqua"},{"text":" as ","color":"#555555"},{"text":"$(player)","color":"white"}]