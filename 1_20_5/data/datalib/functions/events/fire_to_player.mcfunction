$execute unless data storage datalib:engine events.$(event) run return 0

$data modify storage datalib:engine _event_tmp set from storage datalib:engine events.$(event)

$execute as @a[name=$(player),limit=1] run function datalib:core/internal/events/fire_next
data remove storage datalib:engine _event_tmp
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"event/fire_to_player ","color":"aqua"},{"text":"$(event) → $(player)","color":"aqua"}]}
