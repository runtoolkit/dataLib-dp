# ─────────────────────────────────────────────────────────────────
# Obfuscated Validation Layer (f_2a83h)
# Validates state and current isolation buffer (if any).
# Returns 0 -> Invalid / Dangerous (Requires confirmation)
# Returns 1 -> Safe
# ─────────────────────────────────────────────────────────────────

# 1. Reject if validation override flags exist in unrecognized form
execute if data storage datalib:engine security.isolation_buffer{is_dangerous:1b} run return 0
execute if data storage datalib:engine security.isolation_buffer{unrecognized:1b} run return 0

# 2. Strict type checks (ensure security is a compound)
# If someone replaced the security store with a string, it fails.
execute unless data storage datalib:engine security{} run return 0

# 3. Canary must remain 0xCAFEBABE
execute unless data storage datalib:engine security{canary:"0xCAFEBABE"} run return 0

return 1
