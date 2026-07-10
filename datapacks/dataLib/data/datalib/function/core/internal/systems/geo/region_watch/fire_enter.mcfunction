# datalib:systems/geo/region_watch/internal/fire_enter [MACRO]
# INPUT: $(on_enter) — from _rw_cur; called ONLY when on_enter field exists.
# @s = player entering the region

$data modify storage datalib:engine _dispatch.func set value "$(on_enter)"
function #datalib:internal/dispatch
