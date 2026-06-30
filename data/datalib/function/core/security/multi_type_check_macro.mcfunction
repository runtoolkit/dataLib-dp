# datalib:core/security/multi_type_check_macro [MACRO]
# Called with storage datalib:engine {} — reads $(_mcmd_type_tmp) from engine.
# Checks if the type exists as a key in security.multi_type_allowlist.
#
# The caller (multi_type_check.mcfunction) tail-calls this via
# "return run function ...", so THIS function's final command result
# becomes the result the caller returns to its own callers.
#
# BUGFIX: previously this function's last command was always
# "function datalib:core/security/type_violation" or "datalib:core/empty",
# neither of which reflects the allowlist check itself — so callers using
# "execute if/unless function multi_type_check" always saw success,
# silently bypassing the check even when type_violation had fired.
# Now the allowlist check result is re-evaluated as the final command
# via explicit return 1 / return 0.
#
# Note: $(_mcmd_type_tmp) is substituted once when the macro call is
# parsed (from the "with storage" argument), so removing the storage
# value below does not affect the macro lines that reference it above.
$execute unless data storage datalib:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b} run function datalib:core/security/type_violation
$execute store result score #mtc_valid dl.tmp if data storage datalib:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b}
data remove storage datalib:engine _mcmd_type_tmp
return run execute if score #mtc_valid dl.tmp matches 1
