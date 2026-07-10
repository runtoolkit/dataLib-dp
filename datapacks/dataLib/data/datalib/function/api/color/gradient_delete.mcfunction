# datalib:api/color/gradient_delete [MACRO]
# Removes a named gradient from storage.
#
# Input (macro args):
#   name — gradient name to remove
#
# Usage:
#   function datalib:api/color/gradient_delete {name:"health"}

execute unless function datalib:core/security/cmd_gate run return 0

$data remove storage datalib:engine color.gradients.$(name)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/gradient_delete ","color":"aqua"},{"text":"$(name)","color":"white"}]
