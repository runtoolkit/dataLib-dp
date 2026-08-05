# datalib:api/color/validate [MACRO]
# Checks whether a color string is a known named color or a valid hex code.
#
# Named colors accepted:
#   black, dark_blue, dark_green, dark_aqua, dark_red, dark_purple,
#   gold, gray, dark_gray, blue, green, aqua, red, light_purple,
#   yellow, white
#
# Hex accepted: #RRGGBB format (stored as-is; format is not verified at
# mcfunction level — caller must supply a valid string).
#
# Input (macro args):
#   color — color string to validate (e.g. "red", "#FF5500")
#
# Output → datalib:output result
#   1b = valid named color or hex-like string starting with #
#   0b = invalid / unrecognised
#
# Usage:
#   function datalib:api/color/validate {color:"red"}
#   data get storage datalib:output result
#
# Note: hex validation only checks that the value starts with "#".
# Full format validation (#RRGGBB) is not possible in mcfunction alone.

data modify storage datalib:output result set value 0b
$data modify storage datalib:engine _color_validate_tmp set value {color:"$(color)"}
function datalib:core/internal/systems/color/validate_exec with storage datalib:engine _color_validate_tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/validate ","color":"aqua"},{"text":"$(color)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"datalib:output","nbt":"result","color":"green"}]
