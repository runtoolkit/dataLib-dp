# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/from_input_as
# Execute as a specific selector
#
# INPUT (storage datalib:input):
# list → komut listesi
# selector → entity selector (default: @s)
# ─────────────────────────────────────────────────────────────────

execute unless data storage datalib:input selector run data modify storage datalib:input selector set value "@s"

data modify storage datalib:engine _mcmd_queue set from storage datalib:input list
data modify storage datalib:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}

function datalib:core/internal/api/cmd/other/multi_cmd/run_as_exec with storage datalib:input
