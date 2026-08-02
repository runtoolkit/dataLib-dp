# ======================================================================================
# datalib:api/input/private/cbm_process  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a single tagged command_block_minecart. Reads its
# Command NBT into scratch storage, then only proceeds to capture if the
# value is a REAL non-empty string — matching TunnelScript's
# 'execute unless data storage tunnelscript:minecart {current:""}' check,
# not just a path-existence check.
# ======================================================================================

data modify storage datalib:input _cbm.current set from entity @s Command

# Compare the actual VALUE to "" — a compound match, not a path-existence
# check. This is the fix for the false-positive-on-empty-Command bug.
execute unless data storage datalib:input {_cbm:{current:""}} run function datalib:api/input/private/cbm_capture
