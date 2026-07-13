# datalib:systems/hook/internal/exec [MACRO]
# INPUT: $(func) — guaranteed present (check_bind ensures func exists)
# @s = the triggering player

$data modify storage datalib:engine _dispatch.func set value "$(func)"
function #datalib:internal/dispatch
