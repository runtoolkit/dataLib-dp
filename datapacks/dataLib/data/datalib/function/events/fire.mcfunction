$execute unless data storage datalib:engine events.$(event) run execute as @a[tag=datalib.debug] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"event/fire ","color":"aqua"},{"text":"SKIP ","color":"#FF5555"},{"text":"$(event)","color":"#AAAAAA"},{"text":" — no handlers registered","color":"#555555"}]
$execute unless data storage datalib:engine events.$(event) run return 0

$data modify storage datalib:engine _event_tmp set from storage datalib:engine events.$(event)
execute if data storage datalib:engine _event_tmp[0] run function datalib:core/internal/events/fire_next
data remove storage datalib:engine _event_tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"event/fire ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(event)","color":"aqua"}]