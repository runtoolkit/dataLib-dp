$execute unless data storage datalib:engine events.$(event) run return 0

$data modify storage datalib:engine queue append value {func:"datalib:events/internal/fire_deferred", delay:$(delay), event:"$(event)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"event/fire_queued ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(event)","color":"aqua"}]