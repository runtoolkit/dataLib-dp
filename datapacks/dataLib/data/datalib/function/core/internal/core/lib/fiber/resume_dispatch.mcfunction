# datalib:core/lib/fiber/internal/resume_dispatch [MACRO]
# Dispatched via the queue -> queue_run_func -> #datalib:internal/dispatch
# -> core/dispatch/exec chain. core/dispatch/exec forwards the entire
# _dispatch compound as macro context, so $(id)/$(resume) below are the
# id/resume fields this specific queue entry was created with in
# yield_exec.mcfunction — NOT a shared list popped in arrival order.
#
# BUGFIX (concurrency): the previous design wrote a separate FIFO list
# (fibers._pending) on yield, and had resume_dispatch unconditionally
# pop _pending[0] whenever ANY queue entry fired. With 2+ concurrent
# fibers yielding with different delays, process_queue only ever
# advances queue[0] (it never looks past the head of the queue), so a
# short-delay fiber queued behind a longer-delay one would not fire
# until the earlier entry's delay reached 0 — and whichever queue entry
# did fire would resume _pending[0], which could belong to a different
# fiber than the one whose timer actually elapsed. Carrying id/resume
# inside the queue entry itself (and reading them back here via macro
# context) ties each fire event to its own fiber unambiguously, with
# no shared list to desynchronize.
#
# INPUT (macro context from _dispatch, set in yield_exec.mcfunction):
#   $(id)      — fiber id
#   $(resume)  — function to resume

$function datalib:core/internal/core/lib/fiber/resume_exec {id:"$(id)", func:"$(resume)"}
