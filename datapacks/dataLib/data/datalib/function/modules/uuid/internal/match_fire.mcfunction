# ============================================================
# datalib:systems/uuid/internal/match_fire [MACRO]
# Runs the uuid/match callback.
#
# Call: function datalib:modules/uuid/internal/match_fire with storage datalib:input {}
# $(func) = datalib:input func field
# ============================================================
$data modify storage datalib:engine _dispatch.func set value "$(func)"
function #datalib:internal/dispatch
