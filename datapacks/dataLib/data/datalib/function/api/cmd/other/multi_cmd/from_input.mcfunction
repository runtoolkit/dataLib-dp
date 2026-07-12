# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/from_input
# Execute a simple command list (backward compatible)
#
# INPUT (storage datalib:input):
# list → command list ["cmd1", "cmd2", ...]
#
# EXAMPLE:
# data modify storage datalib:input list set value ["say Hello", "say World"]
# function datalib:api/cmd/other/multi_cmd/from_input
# ─────────────────────────────────────────────────────────────────

# Copy list to queue
data modify storage datalib:engine _mcmd_queue set from storage datalib:input list

# Set default options
data modify storage datalib:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}

# Execute
function datalib:api/cmd/other/multi_cmd/run

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/from_input ","color":"aqua"},{"text":"▶ list → run","color":"#555555"}]
