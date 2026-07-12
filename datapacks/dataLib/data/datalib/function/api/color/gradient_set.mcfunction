# datalib:api/color/gradient_set [MACRO]
# Registers a named gradient as an ordered list of color strings.
# Steps are accessed by index via datalib:api/color/lerp.
#
# Input (macro args):
#   name   — gradient name (e.g. "health", "sunset", "xp")
#   colors — SNBT list of color strings, e.g. ["red","yellow","green"]
#            or hex: ["#FF0000","#FFAA00","#00FF00"]
#            Length is arbitrary; step 0 = first entry.
#
# Output → none
#
# Usage:
#   function datalib:api/color/gradient_set {name:"health",\
#     colors:["red","yellow","green"]}
#
#   function datalib:api/color/gradient_set {name:"xp",\
#     colors:["dark_green","green","#AAFF00","yellow"]}
#
# Note: SNBT list syntax requires quotes around string entries.
# This is a load-time operation — call from a load tag or init function.

execute unless function datalib:core/security/cmd_gate run return 0

execute unless data storage datalib:engine color.gradients run data modify storage datalib:engine color.gradients set value {}
$data modify storage datalib:engine color.gradients.$(name) set value $(colors)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/gradient_set ","color":"aqua"},{"text":"$(name)","color":"white"}]
