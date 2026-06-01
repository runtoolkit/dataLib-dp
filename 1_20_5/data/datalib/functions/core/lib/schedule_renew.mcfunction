$execute unless data storage datalib:engine schedules.$(key) run return 0
$data modify storage datalib:engine _sched_tmp set from storage datalib:engine schedules.$(key)
execute if data storage datalib:engine _sched_tmp.func if data storage datalib:engine _sched_tmp.player run function datalib:core/internal/lib/schedule_requeue_as with storage datalib:engine _sched_tmp
execute if data storage datalib:engine _sched_tmp.func unless data storage datalib:engine _sched_tmp.player run function datalib:core/internal/lib/schedule_requeue with storage datalib:engine _sched_tmp
execute if data storage datalib:engine _sched_tmp.cmd if data storage datalib:engine _sched_tmp.player run function datalib:core/internal/lib/schedule_requeue_cmd_as with storage datalib:engine _sched_tmp
execute if data storage datalib:engine _sched_tmp.cmd unless data storage datalib:engine _sched_tmp.player run function datalib:core/internal/lib/schedule_requeue_cmd with storage datalib:engine _sched_tmp
data remove storage datalib:engine _sched_tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_renew ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
