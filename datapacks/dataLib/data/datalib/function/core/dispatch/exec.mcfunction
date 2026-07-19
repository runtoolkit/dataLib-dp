# ─────────────────────────────────────────────────────────────────
# datalib:core/dispatch/exec [MACRO]
# THE ONLY file in dataLib that executes $function $(func).
# Do NOT call directly — use #datalib:internal/dispatch.
#
# INPUT (datalib:engine._dispatch): func → fully-qualified function name
#
# "with storage datalib:engine _dispatch" forwards the entire _dispatch
# compound as macro context to the target function — not just func.
# This lets callers stash extra fields (alongside func) on _dispatch
# before dispatching, and have the target read them as $(...) macro
# args, without this gateway needing to know what those fields are.
# Added so datalib:core/lib/fiber/internal/resume_dispatch (dispatched
# via the process_queue -> queue_run_func -> #datalib:internal/dispatch
# chain) can read $(id)/$(resume) directly instead of relying on a
# separate shared FIFO list that could desync between concurrent
# fibers — see resume_dispatch.mcfunction for the full explanation.
# ─────────────────────────────────────────────────────────────────
$function $(func) with storage datalib:engine _dispatch
