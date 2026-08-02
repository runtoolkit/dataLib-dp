# ─────────────────────────────────────────────────────────────────
# datalib:runtime/lib/batch/begin
# Starts a new batch or clears an existing one.
#
# INPUT (storage datalib:input):
# id → batch id
# spread_over → how many ticks to spread over (default: 1)
# ─────────────────────────────────────────────────────────────────

function datalib:runtime/lib/internal/batch/begin_exec with storage datalib:input {}
