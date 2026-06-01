# datalib:core/internal/systems/hook/check_bind [MACRO]
# INPUT: $(event) - event field of the bind in _hook_ctx
# If it matches _hook_fire_event, run func or cmd.
# @s = tetikleyen oyuncu

$execute if data storage datalib:engine {_hook_fire_event:"$(event)"} if data storage datalib:engine _hook_ctx.func run function datalib:core/internal/systems/hook/exec with storage datalib:engine _hook_ctx
$execute if data storage datalib:engine {_hook_fire_event:"$(event)"} unless data storage datalib:engine _hook_ctx.func run function datalib:core/internal/systems/hook/run_cmd with storage datalib:engine _hook_ctx
