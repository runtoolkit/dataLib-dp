$data modify storage datalib:engine schedules.$(key).func set value "$(func)"
$data modify storage datalib:engine schedules.$(key).interval set value $(interval)
$data modify storage datalib:engine queue append value {func:"$(func)", delay:$(interval)}
