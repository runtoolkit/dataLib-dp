# ─────────────────────────────────────────────────────────────────
# datalib:core/security/cmd_gate
# Central security gate for all execution points.
#
# Integrated with Memory Canaries and strict isolation validation.
# Returns 1  → execution allowed.
# Returns 0  → denied; appropriate fallback already fired.
# ─────────────────────────────────────────────────────────────────

# Guard 1: Engine must be loaded
execute unless data storage datalib:engine global{loaded:1b} run function datalib:core/fallback/not_loaded
execute unless data storage datalib:engine global{loaded:1b} run return 0

# Guard 2: Permission level
execute store result score #sec_req dl.tmp run data get storage datalib:engine security.cmd_min_level
execute if data storage datalib:engine {sandbox:1b} run execute store result score #sec_req dl.tmp run data get storage datalib:engine security.sandbox_cmd_min_level
execute if entity @s[type=player] run execute unless score @s dl.perm_level >= #sec_req dl.tmp run function datalib:core/security/cmd_perm_denied
execute if entity @s[type=player] run execute unless score @s dl.perm_level >= #sec_req dl.tmp run return 0

# Guard 3: Strict Security Pipeline & Memory Canary
# Establish canary in memory
data modify storage datalib:engine security.canary set value "0xCAFEBABE"

# Run Obfuscated Validation (f_2a83h)
execute store success storage datalib:engine security.validation_status int 1 run function datalib:core/security/pipeline/f_2a83h

# Verify Canary Integrity (Zero-tick memory protection)
execute unless data storage datalib:engine security{canary:"0xCAFEBABE"} run return run function datalib:core/security/pipeline/canary_trigger

# Enforce confirmation for unrecognized/dangerous states
execute if data storage datalib:engine security{validation_status:0} run return run function datalib:core/security/pipeline/require_confirm

# Cleanup pipeline state to allow clean execution
data remove storage datalib:engine security.canary
data remove storage datalib:engine security.isolation_buffer

return 1
