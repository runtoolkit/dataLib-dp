# datalib:api/color/lerp [MACRO]
# Looks up a precomputed lerp step from a named gradient table.
# Gradients are registered via datalib:api/color/gradient_set.
#
# This is NOT a real-time RGB interpolator — mcfunction cannot do
# per-channel arithmetic at runtime. Instead, callers pre-register
# a gradient as an ordered list of hex strings and this function
# returns the entry at the given step index.
#
# Input (macro args):
#   gradient — gradient name registered via gradient_set
#   step     — integer index into the gradient list (0-based)
#
# Output → datalib:output result
#   The color string at that step, or "" if out of range.
#
# Usage:
#   # Register once (e.g. at load):
#   function datalib:api/color/gradient_set {name:"sunset",\
#     colors:["#FF0000","#FF5500","#FFAA00","#FFD700","#FFFF00"]}
#
#   # Retrieve at runtime:
#   function datalib:api/color/lerp {gradient:"sunset",step:2}
#   # → datalib:output result = "#FFAA00"

execute unless function datalib:core/security/cmd_gate run return 0

data modify storage datalib:output result set value ""
$execute if data storage datalib:engine color.gradients.$(gradient) run function datalib:systems/color/internal/lerp_exec with storage datalib:input {}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/lerp ","color":"aqua"},{"text":"$(gradient)[$(step)]","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
