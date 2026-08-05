$data modify storage datalib:engine schedules.$(key).cmd set value "$(cmd)"
$data modify storage datalib:engine schedules.$(key).interval set value $(interval)
$data modify storage datalib:engine schedules.$(key).player set value "$(player)"
$data modify storage datalib:engine queue append value {cmd:"$(cmd)", delay:$(interval), player:"$(player)"}
