# datalib:debug/tools/utils/input_check  [1_20_5 OVERLAY]
# Security gate for dataLib function calls.
# Returns 1 → passed. Returns 0 → blocked.

# ── Guard: recursion ────────────────────────────────────────────
execute if data storage datalib:engine global{in_call:1b} run return 1

# ── Guard: engine loaded ─────────────────────────────────────────
execute unless data storage datalib:engine global{loaded:1b} run return 0

# ── Snapshot ────────────────────────────────────────────────────
data modify storage datalib:output inputs set from storage datalib:input
data modify storage datalib:output data set from storage datalib:engine

# ── BLOCK: func missing ──────────────────────────────────────────
execute unless data storage datalib:output inputs.func run return 0

# ── NAMESPACE ALLOWLIST ─────────────────────────────────────────
execute unless data storage datalib:output inputs{func:"datalib:api/"} run function datalib:core/security/input_ns_violation
execute unless data storage datalib:output inputs{func:"datalib:api/"} run return 0

# ── BLOCKLIST: high-risk commands ───────────────────────────────
execute if data storage datalib:output inputs{func:"datalib:api/cmd/op"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/ban"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/ban_ip"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/pardon"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/pardon_ip"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/kick"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/deop"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/stop"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/whitelist"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/save-all"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/save-off"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/save-on"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/data_remove_block"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/data_remove_entity"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/data_remove_storage"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/other/run_self"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/other/multi_cmd_adv"} run return 0

# ── BLOCKLIST: storage injection ────────────────────────────────
execute if data storage datalib:output inputs{func:"with storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{func:"with storage datalib:output"} run return 0

# ── EXECUTE VALIDATED ───────────────────────────────────────────
data modify storage datalib:engine global.in_call set value 1b
function datalib:core/engine/call/execute_validated
data remove storage datalib:engine global.in_call

data remove storage datalib:output data
data remove storage datalib:output security
data remove storage datalib:output inputs
return 1
