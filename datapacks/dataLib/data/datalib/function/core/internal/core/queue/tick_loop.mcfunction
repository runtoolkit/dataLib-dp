# datalib:core/queue/internal/tick_loop
# Recursive loop: processes one item then calls itself until
# #wq_rate reaches 0 or the queue is empty.
# Max recursion depth = work_queue_rate (keep ≤ 64 for safety).

execute unless data storage datalib:engine work_queue[0] run return 0
execute if score #wq_rate dl.tmp matches ..0 run return 0

scoreboard players remove #wq_rate dl.tmp 1
function datalib:core/internal/core/queue/exec_next

function datalib:core/internal/core/queue/tick_loop
