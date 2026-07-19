# datalib:api/gamerule/internal/dispatch
# Evaluates the value and calls the appropriate callback function.
# Called exclusively by datalib:api/gamerule/set — do NOT call directly.
#
# INPUT (storage datalib:input):
#   value        — raw value string: "true", "false", or numeric string
#   gr_on_true   — (optional) function to call when value is "true"
#   gr_on_false  — (optional) function to call when value is "false"
#   gr_on_value  — (optional) function to call for numeric match
#   gr_matches   — (optional) scoreboard range string, e.g. "5..10"

# ── Boolean: true ────────────────────────────────────────────────────────────
execute if data storage datalib:input {value:"true"} if data storage datalib:input gr_on_true run return run function datalib:core/internal/api/gamerule/call_on_true with storage datalib:input {}

# ── Boolean: false ───────────────────────────────────────────────────────────
execute if data storage datalib:input {value:"false"} if data storage datalib:input gr_on_false run return run function datalib:core/internal/api/gamerule/call_on_false with storage datalib:input {}

# ── Numeric with explicit matches range ──────────────────────────────────────
execute if data storage datalib:input gr_on_value if data storage datalib:input gr_matches run function datalib:core/internal/api/gamerule/numeric_check with storage datalib:input {}
