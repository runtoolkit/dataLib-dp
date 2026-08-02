# datalib:core/queue/internal/flush_loop
# Drains the entire work_queue in one call stack (used by queue/flush).
# Recursion depth = queue size — do NOT call on large queues.

execute unless data storage datalib:engine work_queue[0] run return 0
function datalib:runtime/queue/internal/exec_next
function datalib:runtime/queue/internal/flush_loop
