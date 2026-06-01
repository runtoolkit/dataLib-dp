# ─────────────────────────────────────────────────────────────────
# datalib:core/internal/api/cmd/other/multi_cmd/step
# Dequeue one command and execute it, then recurse
# ─────────────────────────────────────────────────────────────────

# Return if queue is empty
execute unless data storage datalib:engine _mcmd_queue[0] run return 0

# Dequeue first command
data modify storage datalib:engine _mcmd_current set from storage datalib:engine _mcmd_queue[0]
data remove storage datalib:engine _mcmd_queue[0]

# Increment stats counter
execute if data storage datalib:engine _mcmd_options{profile:1b} run scoreboard players add $mcmd_total dl.tmp 1

# Execute command (string or object)
execute if data storage datalib:engine _mcmd_current{} run function datalib:core/internal/api/cmd/other/multi_cmd/exec_object
execute unless data storage datalib:engine _mcmd_current{} run function datalib:core/internal/api/cmd/other/multi_cmd/exec_string

# Process next command
function datalib:core/internal/api/cmd/other/multi_cmd/step
