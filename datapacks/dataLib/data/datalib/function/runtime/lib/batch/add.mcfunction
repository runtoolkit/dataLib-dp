# ─────────────────────────────────────────────────────────────────
# datalib:runtime/lib/batch/add
# Adds a job to the batch queue.
#
# INPUT (storage datalib:input):
# id → batch id
# func → function to run (opsiyonel)
# cmd → command to run (optional, used if no func)
# ─────────────────────────────────────────────────────────────────

function datalib:runtime/lib/internal/batch/add_exec with storage datalib:input {}
