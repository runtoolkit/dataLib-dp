# datalib:core/internal/queue/exec_next
# Pops work_queue[0] into _wq_job, removes it from the list,
# then dispatches to the appropriate runner.
# player field present → execute as that player (skipped if offline).
# player field absent  → run in server context.

data modify storage datalib:engine _wq_job set from storage datalib:engine work_queue[0]
data remove storage datalib:engine work_queue[0]

execute if data storage datalib:engine _wq_job.player run function datalib:core/internal/queue/exec_as with storage datalib:engine _wq_job
execute unless data storage datalib:engine _wq_job.player run function datalib:core/internal/queue/exec_fn with storage datalib:engine _wq_job

data remove storage datalib:engine _wq_job
