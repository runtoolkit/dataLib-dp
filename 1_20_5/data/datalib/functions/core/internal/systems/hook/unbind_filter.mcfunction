# datalib:core/internal/systems/hook/unbind_filter
# _hook_unbinds listesini iterate eder.
# Copies back binds that do not match _hook_filter_event to hook_binds.

execute unless data storage datalib:engine _hook_unbinds[0] run return 0

data modify storage datalib:engine _hook_unbinds[0] set from storage datalib:engine _hook_unbinds[0]

function datalib:core/internal/systems/hook/unbind_check with storage datalib:engine _hook_unbinds[0]

data remove storage datalib:engine _hook_unbinds[0]

function datalib:core/internal/systems/hook/unbind_filter
