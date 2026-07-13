# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/freeze/internal/remove  [INTERNAL]
# Runs AS the player being unfrozen.
#
# Copies the player's datalib.pid to tmp, then kills every anchor
# stand whose dl.freeze_id matches (should always be exactly one).
# Then removes the datalib.frozen tag so the tick function's
# early-exit check fires and no further TPs occur.
# ─────────────────────────────────────────────────────────────────

# Store this player's PID so we can match it against anchor stands
scoreboard players operation $freeze_rm dl.tmp = @s datalib.pid

# Kill the matching anchor stand
execute as @e[tag=datalib.freeze_anchor] if score @s dl.freeze_id = $freeze_rm dl.tmp run kill @s

# Unfreeze the player
tag @s remove datalib.frozen

# Notify and play sound
playsound datalib:ui.unfreeze master @s ~ ~ ~ 0.7 1.3
tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"translate":"datalib.msg.unfreeze","color":"#55ff55","bold":true}]
