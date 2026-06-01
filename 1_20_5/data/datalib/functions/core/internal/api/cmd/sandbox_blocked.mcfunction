# datalib:core/internal/api/cmd/sandbox_blocked [1.20.5 overlay]
# Called by cmd/ files when sandbox:1b is active AND command is NOT in allowlist.
# Reads datalib:engine _sandbox_cmd (set by caller), logs, notifies, and kicks.
#
# NOTE (v5.1.2): Primary enforcement path now goes through sandbox_gate.
# This function is retained for direct callers and backwards compatibility.
function datalib:core/internal/api/cmd/sandbox_blocked_macro with storage datalib:engine {}
