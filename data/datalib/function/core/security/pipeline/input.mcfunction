# 1. Storage -> Isolation
$data modify storage datalib:engine security.isolation_buffer set value "$(cmd)"

# 2. Memory Canary Setup
data modify storage datalib:engine security.canary set value "0xCAFEBABE"

# 3. Validation
execute store success storage datalib:engine security.validation_status int 1 run function datalib:core/security/pipeline/f_2a83h

# Check Canary
execute unless data storage datalib:engine security{canary:"0xCAFEBABE"} run return run function datalib:core/security/pipeline/canary_trigger

# 4. Confirmation if unrecognized/dangerous
execute if data storage datalib:engine security{validation_status:0} run return run function datalib:core/security/pipeline/require_confirm

# 5. Run & Cleanup (Isolated execution via macro)
$function datalib:core/security/pipeline/execute {"cmd":"$(cmd)"}
