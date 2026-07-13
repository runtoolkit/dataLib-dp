execute unless function datalib:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/unfreeze
# Releases a player previously frozen by datalib:api/cmd/freeze.
#
# 1. Finds the frozen player's datalib.pid.
# 2. Kills the anchor armor stand whose dl.freeze_id matches.
# 3. Removes the datalib.frozen tag so the tick function stops
#    teleporting them.
# 4. Plays the unfreeze sound and notifies the player.
#
# INPUT : $(player) → exact player name
#
# EXAMPLE:
#   function datalib:api/cmd/unfreeze {player:"Steve"}
# ─────────────────────────────────────────────────────────────────

$execute as @a[name=$(player),tag=datalib.frozen,limit=1] run function datalib:core/internal/api/cmd/freeze/remove
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/unfreeze ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"translate":"datalib.msg.unfreeze","color":"#55ff55","bold":true}]
