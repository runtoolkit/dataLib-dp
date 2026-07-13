# datalib:api/color/palette_delete [MACRO]
# Removes a color alias from the runtime palette.
#
# Input (macro args):
#   key — alias name to remove
#
# Output → none
#
# Usage:
#   function datalib:api/color/palette_delete {key:"brand"}

execute unless function datalib:core/security/cmd_gate run return 0

$data remove storage datalib:engine color.palette.$(key)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/palette_delete ","color":"aqua"},{"text":"$(key)","color":"white"}]
