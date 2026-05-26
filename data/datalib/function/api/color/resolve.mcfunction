# datalib:api/color/resolve [MACRO]
# Looks up a named palette entry or returns the value as-is if not found.
# Use this to map short alias keys (e.g. "brand", "danger", "info") to hex.
#
# The palette is stored in datalib:engine color.palette as a compound:
#   {brand:"#00AAAA", danger:"red", info:"aqua", ...}
# Populate via datalib:api/color/palette_set.
#
# Input (macro args):
#   color — alias key or direct color value
#
# Output → datalib:output result
#   The resolved color string (palette value if key found; input value otherwise).
#
# Usage:
#   function datalib:api/color/resolve {color:"brand"}
#   # → datalib:output result = "#00AAAA"  (if palette has brand→#00AAAA)
#
#   function datalib:api/color/resolve {color:"red"}
#   # → datalib:output result = "red"  (not in palette, returned as-is)

execute unless function datalib:core/security/cmd_gate run return 0

# Default: return input value
$data modify storage datalib:output result set value "$(color)"

# Override if palette has this key
$execute if data storage datalib:engine color.palette run function datalib:systems/color/internal/resolve_exec with storage datalib:engine color {}

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/resolve ","color":"aqua"},{"text":"$(color)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
