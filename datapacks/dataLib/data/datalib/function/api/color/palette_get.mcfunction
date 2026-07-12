# datalib:api/color/palette_get [MACRO]
# Reads a color alias from the runtime palette.
#
# Input (macro args):
#   key — alias name (e.g. "brand")
#
# Output → datalib:output result
#   The stored color value, or absent if key not found.
#
# Usage:
#   function datalib:api/color/palette_get {key:"brand"}
#   data get storage datalib:output result

execute unless function datalib:core/security/cmd_gate run return 0

data modify storage datalib:output result set value ""
$execute if data storage datalib:engine color.palette.$(key) run data modify storage datalib:output result set from storage datalib:engine color.palette.$(key)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/palette_get ","color":"aqua"},{"text":"$(key)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"datalib:output","nbt":"result","color":"green"}]
