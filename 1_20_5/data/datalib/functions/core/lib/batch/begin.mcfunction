# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/batch/begin
# Starts a new batch or clears an existing one.
#
# INPUT (storage datalib:input):
# id → batch id
# spread_over → how many ticks to spread over (default: 1)
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/lib/batch/begin_exec with storage datalib:engine {}
