# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/batch/flush
# Splits batch jobs across spread_over ticks and adds them to process_queue.
# Jobs per tick: ceil(items / spread_over).
# Batch record is deleted after flush.
#
# INPUT (storage datalib:input):
# id → batch id
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/lib/batch/flush_exec with storage datalib:engine {}
