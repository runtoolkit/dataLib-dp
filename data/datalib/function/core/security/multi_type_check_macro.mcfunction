# datalib:core/security/multi_type_check_macro [MACRO]
# Called with storage datalib:engine {} — reads $(_mcmd_type_tmp) from engine.
# Checks if the type exists as a key in security.multi_type_allowlist.
#
# BUGFIX: the allowlist check result is re-evaluated as the final command
# via explicit return 1 / return 0 so callers get the correct result.
$execute unless data storage datalib:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b} run function datalib:core/security/type_violation
$execute store result score #mtc_valid dl.tmp if data storage datalib:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b}
data remove storage datalib:engine _mcmd_type_tmp
return run execute if score #mtc_valid dl.tmp matches 1
