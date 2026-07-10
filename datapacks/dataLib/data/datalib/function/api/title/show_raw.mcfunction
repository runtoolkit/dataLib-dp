# datalib:api/title/show_raw — Atomic title display with raw JSON [MACRO]
# Like title/show but accepts full serialized JSON component strings,
# allowing gradients, translate, score, selector, and nbt text sources.
#
# Input (macro args):
#   player        — player name selector string (e.g. "Steve")
#   title_json    — serialized JSON component for title    (must be a valid JSON text component)
#   subtitle_json — serialized JSON component for subtitle (must be a valid JSON text component)
#   fade_in       — ticks to fade in
#   stay          — ticks to stay
#   fade_out      — ticks to fade out
#
# Output → none
#
# Usage:
#   function datalib:api/title/show_raw {player:"Steve",\
#     title_json:'{"text":"Hello","color":"gold","bold":true}',\
#     subtitle_json:'[{"text":"Welcome "},{"score":{"name":"@s","objective":"kills"}}]',\
#     fade_in:10,stay:70,fade_out:20}

execute unless function datalib:debug/tools/utils/check_all run return 0

$title @a[name=$(player),limit=1] times $(fade_in) $(stay) $(fade_out)
$title @a[name=$(player),limit=1] title $(title_json)
$title @a[name=$(player),limit=1] subtitle $(subtitle_json)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"title/show_raw ","color":"aqua"},{"text":"$(player)","color":"white"}]
