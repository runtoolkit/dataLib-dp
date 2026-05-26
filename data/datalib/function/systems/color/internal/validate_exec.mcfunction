# datalib:systems/color/internal/validate_exec [MACRO]
# Internal — called by api/color/validate.
# Sets datalib:output result to 1b if $(color) is a known named color,
# or if it begins with "#" (hex shorthand detection).
$execute if data storage datalib:engine color._names{$(color):1b} run data modify storage datalib:output result set value 1b
