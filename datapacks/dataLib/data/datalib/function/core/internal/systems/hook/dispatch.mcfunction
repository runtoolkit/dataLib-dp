# datalib:systems/hook/internal/dispatch
# Iterates _hook_iter list, runs matching events.

execute unless data storage datalib:engine _hook_iter[0] run return 0

data modify storage datalib:engine _hook_ctx set from storage datalib:engine _hook_iter[0]
data remove storage datalib:engine _hook_iter[0]

function datalib:core/internal/systems/hook/check_bind with storage datalib:engine _hook_ctx

function datalib:core/internal/systems/hook/dispatch
