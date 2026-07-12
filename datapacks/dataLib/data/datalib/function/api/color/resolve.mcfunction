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

# Default: return input value
$data modify storage datalib:output result set value "$(color)"

# Override if palette has this key — write color key into temp so resolve_exec can access it
$data modify storage datalib:engine _color_resolve_tmp set value {color:"$(color)"}
execute if data storage datalib:engine color.palette run function datalib:core/internal/systems/color/resolve_exec with storage datalib:engine _color_resolve_tmp
data remove storage datalib:engine _color_resolve_tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"color/resolve ","color":"aqua"},{"text":"$(color)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"datalib:output","nbt":"result","color":"green"}]
