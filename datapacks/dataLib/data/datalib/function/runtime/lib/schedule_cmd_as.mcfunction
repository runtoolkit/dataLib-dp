$execute if data storage datalib:engine schedules.$(key) run data remove storage datalib:engine schedules.$(key)

$data modify storage datalib:engine schedules.$(key).cmd set value "$(cmd)"
$data modify storage datalib:engine schedules.$(key).interval set value $(interval)
$data modify storage datalib:engine schedules.$(key).player set value "$(player)"
$data modify storage datalib:engine queue append value {cmd:"$(cmd)", delay:$(interval), player:"$(player)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_cmd_as ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" as $(player)","color":"#555555"}]
