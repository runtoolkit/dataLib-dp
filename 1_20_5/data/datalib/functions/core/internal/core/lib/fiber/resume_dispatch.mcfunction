# datalib:core/internal/lib/fiber/resume_dispatch
# Called by process_queue.
# Pops _pending[0], checks fiber alive status, runs the function.

execute unless data storage datalib:engine fibers._pending[0] run return 0

data modify storage datalib:engine _fib_cur set from storage datalib:engine fibers._pending[0]
data remove storage datalib:engine fibers._pending[0]

function datalib:core/internal/lib/fiber/resume_exec with storage datalib:engine _fib_cur
data remove storage datalib:engine _fib_cur