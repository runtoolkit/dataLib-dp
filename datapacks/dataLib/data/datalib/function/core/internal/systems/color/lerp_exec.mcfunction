# datalib:systems/color/internal/lerp_exec [MACRO]
# Internal — called by api/color/lerp.
# Reads datalib:engine color.gradients.$(gradient)[$(step)] into output.
$data modify storage datalib:output result set from storage datalib:engine color.gradients.$(gradient)[$(step)]
