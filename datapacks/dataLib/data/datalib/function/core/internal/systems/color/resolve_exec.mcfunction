# datalib:systems/color/internal/resolve_exec [MACRO]
# Called with storage datalib:engine color {} — reads palette.$(color).
# If the key exists in palette, copies it to datalib:output result.
# Uses the outer $(color) macro arg captured by api/color/resolve.
# NOTE: This file is called with `with storage datalib:engine color {}`
# so macro args come from the color compound (which contains "palette").
# The $(color) arg is forwarded from the parent macro frame.
$execute if data storage datalib:engine color.palette.$(color) run data modify storage datalib:output result set from storage datalib:engine color.palette.$(color)
