execute unless function datalib:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/freeze
# Freezes a player in place using an invisible marker armor stand.
# Every tick the frozen player is teleported back to the stand's
# position, preventing any movement. This is the only reliable
# vanilla method — player NBT is read-only so FrozenTicks cannot
# be set, and Slowness 255 alone does not stop client-side movement.
#
# On freeze: a marker armor stand is summoned at the player's feet,
# the player's datalib.pid is copied to the stand's dl.freeze_id,
# and the player receives the datalib.frozen tag.
#
# The per-tick teleport back is handled by:
#   datalib:api/cmd/freeze/internal/tick  (hooked via #datalib:events/on_tick)
#
# Use datalib:api/cmd/unfreeze to release.
#
# INPUT : $(player) → exact player name
#
# EXAMPLE:
#   function datalib:api/cmd/freeze {player:"Steve"}
# ─────────────────────────────────────────────────────────────────

$execute as @a[name=$(player),tag=!datalib.frozen,limit=1] run function datalib:core/internal/api/cmd/freeze/apply
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/freeze ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"translate":"datalib.msg.freeze","color":"#00aaff","bold":true}]
