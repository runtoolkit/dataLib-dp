# ─────────────────────────────────────────────
# datalib:core/engine/call/execute_validated/run
# Expands and runs the validated function via datalib.
#  Gets $(func) variable from datalib:output.inputs storage,
# uses datalib:input storage as the parameter source.
# ─────────────────────────────────────────────

$function $(func) with storage datalib:input {}
