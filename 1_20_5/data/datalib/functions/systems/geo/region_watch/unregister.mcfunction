# ─────────────────────────────────────────────────────────────────
# datalib:systems/geo/region_watch/unregister
# Deletes a registered region. Player state scores are not cleared
# (automatically skipped in the next tick_scan loop).
#
# INPUT (storage datalib:input):
# id → region id
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/geo/region_watch/unregister_exec with storage datalib:engine {}
