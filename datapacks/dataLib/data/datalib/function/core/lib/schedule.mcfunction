$execute if data storage datalib:engine schedules.$(key) run data remove storage datalib:engine schedules.$(key)

$data modify storage datalib:engine schedules.$(key).func set value "$(func)"
$data modify storage datalib:engine schedules.$(key).interval set value $(interval)
$data modify storage datalib:engine queue append value {func:"$(func)", delay:$(interval)}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/schedule ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
