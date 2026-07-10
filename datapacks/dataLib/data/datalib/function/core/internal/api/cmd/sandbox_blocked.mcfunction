# datalib:api/cmd/internal/sandbox_blocked
# Called by cmd/ files when sandbox:1b is active AND command is NOT in allowlist.
# Reads datalib:engine _sandbox_cmd (set by caller), logs, notifies, and kicks.
function datalib:core/internal/api/cmd/sandbox_blocked_macro with storage datalib:engine {}
