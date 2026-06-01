# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/run_func
# Run function list
#
# INPUT (storage datalib:input):
# list → function list ["pack:func1", "pack:func2"]
# ─────────────────────────────────────────────────────────────────

# Convert strings to {func:"..."} format
data modify storage datalib:engine _mcmd_queue set value []
function datalib:core/internal/api/cmd/other/multi_cmd/func_convert_loop

data modify storage datalib:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}
function datalib:api/cmd/other/multi_cmd/run

data remove storage datalib:engine _mcmd_func_tmp
