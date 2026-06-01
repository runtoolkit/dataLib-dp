# datalib:core/internal/queue/tick
# Rate-limited work queue dispatcher — called every tick by tick.mcfunction.
# Reads work_queue_rate and processes up to that many items.
# Early-exit if queue is empty (zero overhead when idle).

execute unless data storage datalib:engine work_queue[0] run return 0

execute store result score #wq_rate dl.tmp run data get storage datalib:engine work_queue_rate
execute if score #wq_rate dl.tmp matches ..0 run return 0

function datalib:core/internal/queue/tick_loop
