# datalib:api/cmd/internal/sandbox_gate_macro [MACRO]
# Called with storage datalib:engine {} — reads $(_sandbox_cmd) from engine storage.
# Returns 1 if command is in sandbox_allowlist (compound key lookup).
# Calls type_violation (log + kick) and returns 0 if blocked.
$execute if data storage datalib:engine security.sandbox_allowlist{$(_sandbox_cmd):1b} run return 1
# Not in allowlist
data modify storage datalib:input _violation_type set from storage datalib:engine _sandbox_cmd
function datalib:core/security/type_violation
data remove storage datalib:input _violation_type
return 0
