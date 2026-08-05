$execute unless data storage datalib:engine schedules.$(key) run return 0

$data modify storage datalib:engine _sreset set from storage datalib:engine schedules.$(key)
$data modify storage datalib:engine _sreset.key set value "$(key)"

$data remove storage datalib:engine schedules.$(key)

execute if data storage datalib:engine _sreset.func if data storage datalib:engine _sreset.player run function datalib:core/internal/core/lib/schedule_reset_do_as with storage datalib:engine _sreset
execute if data storage datalib:engine _sreset.func unless data storage datalib:engine _sreset.player run function datalib:core/internal/core/lib/schedule_reset_do with storage datalib:engine _sreset
execute if data storage datalib:engine _sreset.cmd if data storage datalib:engine _sreset.player run function datalib:core/internal/core/lib/schedule_reset_do_cmd_as with storage datalib:engine _sreset
execute if data storage datalib:engine _sreset.cmd unless data storage datalib:engine _sreset.player run function datalib:core/internal/core/lib/schedule_reset_do_cmd with storage datalib:engine _sreset
data remove storage datalib:engine _sreset
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_reset ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
