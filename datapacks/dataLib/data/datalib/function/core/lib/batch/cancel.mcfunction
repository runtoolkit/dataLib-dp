# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/batch/cancel
# Cancels a batch that has not been flushed.
# Items already flushed and queued cannot be cancelled
# (pulling from process_queue is not supported — dataLib design constraint).
#
# INPUT (storage datalib:input):
# id → batch id
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/core/lib/batch/cancel_exec with storage datalib:input {}
