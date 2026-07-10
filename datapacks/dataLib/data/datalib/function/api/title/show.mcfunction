# datalib:api/title/show — Atomic title display [MACRO]
# Sets display timing then shows title + subtitle for one player in a single call.
# Unlike calling cmd/title_times + cmd/title + cmd/subtitle separately,
# this guarantees consistent timing for the title/subtitle pair.
#
# Input (macro args):
#   player    — player name selector string (e.g. "Steve")
#   title     — title text
#   subtitle  — subtitle text
#   color     — title color    (e.g. "gold", "#RRGGBB")
#   sub_color — subtitle color (e.g. "gray", "#RRGGBB")
#   fade_in   — ticks to fade in  (e.g. 10)
#   stay      — ticks to stay     (e.g. 60)
#   fade_out  — ticks to fade out (e.g. 10)
#
# Output → none
#
# Usage:
#   function datalib:api/title/show {player:"Steve",title:"Hello",subtitle:"welcome back",\
#     color:"gold",sub_color:"gray",fade_in:10,stay:60,fade_out:10}

execute unless function datalib:debug/tools/utils/check_all run return 0

$title @a[name=$(player),limit=1] times $(fade_in) $(stay) $(fade_out)
$title @a[name=$(player),limit=1] title {"text":"$(title)","color":"$(color)"}
$title @a[name=$(player),limit=1] subtitle {"text":"$(subtitle)","color":"$(sub_color)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"title/show ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(title)","color":"$(color)"},{"text":" / ","color":"#555555"},{"text":"$(subtitle)","color":"$(sub_color)"}]
