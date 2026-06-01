# datalib:core/internal/systems/hook/fire [MACRO]
# INPUT: $(event) — event name to fire
# @s = tetikleyen oyuncu
# Copies hook_binds list and dispatches it.

$data modify storage datalib:engine _hook_fire_event set value "$(event)"
data modify storage datalib:engine _hook_iter set from storage datalib:engine hook_binds

execute if data storage datalib:engine _hook_iter run function datalib:core/internal/systems/hook/dispatch

data remove storage datalib:engine _hook_iter
data remove storage datalib:engine _hook_fire_event
