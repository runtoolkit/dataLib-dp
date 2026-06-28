# datalib:core/security/multi_type_check
# Validates datalib:engine multiCommands.type against security.multi_type_allowlist.
# Called before executing multi_cmd or multi_cmd_adv operations.
#
# Returns 1 → type is valid.
# Returns 0 → type violation fired (log + kick).
#
# BUGFIX: the function previously ended with "data remove ... _mcmd_type_tmp",
# which always succeeds (returns 1) regardless of the allowlist check.
# Callers using "execute if/unless function" always read success=1,
# silently bypassing the check. Cleanup now happens inside the macro,
# and the macro returns the real allowlist result via "return run execute".
data modify storage datalib:engine _mcmd_type_tmp set from storage datalib:engine multiCommands.type
return run function datalib:core/security/multi_type_check_macro with storage datalib:engine {}
