# datalib:core/security/multi_type_check
# Validates datalib:engine multiCommands.type against security.multi_type_allowlist.
# Called before executing multi_cmd or multi_cmd_adv operations.
#
# Returns 1 → type is valid.
# Returns 0 → type violation fired (log + kick).
#
# BUGFIX: the final command of this function must reflect the allowlist
# result. Previously the last command was "data remove ... _mcmd_type_tmp",
# which always succeeds regardless of the check outcome — callers using
# "execute if/unless function datalib:core/security/multi_type_check"
# always read success=1, so the type-check was silently bypassed even
# when type_violation had already fired. The check, the _mcmd_type_tmp
# cleanup, and the real return value are now all handled inside
# multi_type_check_macro.mcfunction, whose final command this tail-call
# forwards as this function's own result.
data modify storage datalib:engine _mcmd_type_tmp set from storage datalib:engine multiCommands.type
return run function datalib:core/security/multi_type_check_macro with storage datalib:engine {}
