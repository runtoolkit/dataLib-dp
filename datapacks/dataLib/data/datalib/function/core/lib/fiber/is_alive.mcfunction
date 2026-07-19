# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/fiber/is_alive
# Checks whether a fiber is active.
#
# INPUT (storage datalib:input):
# id → fiber id
#
# OUTPUT (storage datalib:output):
# result → 1b (active) | 0b (dead or never started)
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/core/lib/fiber/is_alive_exec with storage datalib:input {}
