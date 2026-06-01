# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/batch/cancel
# Cancels a batch that has not been flushed.
# Items already flushed and queued cannot be cancelled
# (pulling from process_queue is not supported — AME design constraint).
#
# INPUT (storage datalib:input):
# id → batch id
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/lib/batch/cancel_exec with storage datalib:engine {}
