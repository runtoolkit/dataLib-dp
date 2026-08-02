# ─────────────────────────────────────────────────────────────────
# datalib:internal/geo/api/region_watch/unregister
# Deletes a registered region. Player state scores are not cleared
# (automatically skipped in the next tick_scan loop).
#
# INPUT (storage datalib:input):
# id → region id
# ─────────────────────────────────────────────────────────────────

function datalib:internal/geo/region_watch/unregister_exec with storage datalib:input {}
