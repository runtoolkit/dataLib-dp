# datalib:core/lib/fiber/internal/yield_exec [MACRO]
# INPUT: $(id), $(resume), $(delay)

# Do not continue if fiber is dead
$execute unless data storage datalib:engine fibers.$(id){alive:1b} run return 0

# Write resume point to fiber record (readable by is_alive/resume)
$data modify storage datalib:engine fibers.$(id).resume set value "$(resume)"

# BUGFIX: previously this wrote a separate FIFO list (fibers._pending)
# and a separate process_queue entry, on the assumption that
# resume_dispatch would always consume them in lockstep (one queue
# entry firing == _pending[0] belongs to that same yield call).
# That assumption breaks with 2+ concurrent fibers: process_queue only
# decrements queue[0].delay each tick (it never looks past the head),
# so a fiber that yields with a short delay can get stuck behind an
# earlier entry with a longer delay, and whichever queue entry fires
# first ends up popping _pending[0] — which may belong to a different
# fiber than the one whose timer actually elapsed.
#
# Fix: the resume target (id + func) now travels INSIDE the queue
# entry itself (id/resume fields), so when this specific queue entry
# fires, queue_run_func passes it straight through as macro args to
# resume_dispatch — no shared list to desynchronize.
$data modify storage datalib:engine queue append value {func:"datalib:core/internal/core/lib/fiber/resume_dispatch", delay:$(delay), id:"$(id)", resume:"$(resume)"}

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/yield ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(resume)","color":"aqua"},{"text":" in $(delay)t","color":"#555555"}]
