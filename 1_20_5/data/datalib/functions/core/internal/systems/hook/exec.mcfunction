# datalib:core/internal/systems/hook/exec [MACRO]
# INPUT: $(func) — guaranteed present (check_bind ensures func exists)
# @s = tetikleyen oyuncu

$data modify storage datalib:engine _dispatch.func set value "$(func)"
function #datalib:internal/dispatch
