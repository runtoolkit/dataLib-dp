# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/fiber/kill
# Stops a fiber. Pending resumes in the queue will not run.
#
# INPUT (storage datalib:input):
# id → fiber id
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/lib/fiber/kill_exec with storage datalib:engine {}
