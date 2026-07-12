# ─────────────────────────────────────────────
# datalib:core/engine/call/execute_validated
# Runs a function that has passed security validation.
# Called only by datalib:debug/tools/utils/input_check.
#
# Girdi (datalib:output.inputs):
# func — function name to run (already validated)
# Veri (datalib:input):
# All parameters to pass to the function
# ─────────────────────────────────────────────

# Pass validated func name to macro sub-function and run
function datalib:core/engine/call/execute_validated/run with storage datalib:output inputs
