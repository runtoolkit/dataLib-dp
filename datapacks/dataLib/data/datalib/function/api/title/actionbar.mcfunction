# datalib:api/title/actionbar — Raw JSON actionbar display [MACRO]
# Displays a full JSON component string in the actionbar of a named player.
# Unlike cmd/actionbar (text + color only), this accepts any serialized component
# including gradients, translate, score, selector, and nbt text sources.
#
# Input (macro args):
#   player — player name selector string (e.g. "Steve")
#   json   — serialized JSON component string
#
# Output → none
#
# Usage:
#   function datalib:api/title/actionbar {player:"Steve",json:'{"text":"HP: 20/20","color":"red"}'}
#   function datalib:api/title/actionbar {player:"Steve",\
#     json:'[{"text":"Kills: "},{"score":{"name":"@s","objective":"kills"},"color":"gold"}]'}

execute unless function datalib:debug/tools/utils/check_all run return 0

$title @a[name=$(player),limit=1] actionbar $(json)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"title/actionbar ","color":"aqua"},{"text":"$(player)","color":"white"}]
