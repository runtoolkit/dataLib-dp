# datalib:core/internal/api/cmd/sandbox_gate
# Allowlist-aware sandbox gate for cmd/ functions.
# Integrated with Memory Canaries for strict sandbox isolation.
#
# Returns 1 → command is allowlisted — execution continues.
# Returns 0 → command is blocked + player kicked — execution halts.

# Set up canary in memory
data modify storage datalib:engine security.canary set value "0xCAFEBABE"

# Run Obfuscated Validation (f_2a83h)
execute store success storage datalib:engine security.validation_status int 1 run function datalib:core/security/pipeline/f_2a83h

# If Canary was manipulated -> HALT
execute unless data storage datalib:engine security{canary:"0xCAFEBABE"} run return run function datalib:core/security/pipeline/canary_trigger

# Proceed to standard macro evaluation
function datalib:core/internal/api/cmd/sandbox_gate_macro with storage datalib:engine {}

# Cleanup
data remove storage datalib:engine security.canary
