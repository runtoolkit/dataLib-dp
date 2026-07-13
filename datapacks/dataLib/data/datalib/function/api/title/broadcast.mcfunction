# datalib:api/title/broadcast — Broadcast title + subtitle + times to all players [MACRO]
# Sends a complete title display (timing + title + subtitle) to every online player.
# Unlike cmd/title_all which only sends a plain title to @a with no subtitle or
# timing control, this sets times and subtitle in the same atomic call.
#
# Input (macro args):
#   title     — title text
#   subtitle  — subtitle text
#   color     — title color    (e.g. "red", "#RRGGBB")
#   sub_color — subtitle color (e.g. "yellow", "#RRGGBB")
#   fade_in   — ticks to fade in  (e.g. 20)
#   stay      — ticks to stay     (e.g. 100)
#   fade_out  — ticks to fade out (e.g. 20)
#
# Output → none
#
# Usage:
#   function datalib:api/title/broadcast {title:"Server restart in 5 min",\
#     subtitle:"Save your progress!",color:"red",sub_color:"yellow",\
#     fade_in:20,stay:100,fade_out:20}

execute unless function datalib:debug/tools/utils/check_all run return 0

$title @a times $(fade_in) $(stay) $(fade_out)
$title @a title {"text":"$(title)","color":"$(color)"}
$title @a subtitle {"text":"$(subtitle)","color":"$(sub_color)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"title/broadcast ","color":"aqua"},{"text":"@a ","color":"gray"},{"text":"→ ","color":"#555555"},{"text":"$(title)","color":"$(color)"},{"text":" / ","color":"#555555"},{"text":"$(subtitle)","color":"$(sub_color)"}]
