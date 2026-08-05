# ─────────────────────────────────────────────────────────────────
# datalib:core/dispatch/run
# Central function dispatch gateway — called via #datalib:internal/dispatch.
# Reads func from datalib:engine._dispatch and calls exec via datalib.
#
# Override #datalib:internal/dispatch in your overlay/pack to inject
# validation or logging without touching call sites.
# ─────────────────────────────────────────────────────────────────
function datalib:core/dispatch/exec with storage datalib:engine _dispatch
