# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/freeze/internal/anchor_tp  [INTERNAL]
# Called every tick via freeze/internal/tick, once per anchor stand.
# Execution context: AS = anchor armor stand, AT = stand's position.
#
# Reads this stand's dl.freeze_id into a tmp score, then teleports
# the frozen player whose datalib.pid matches that value back to
# this exact position (~ ~ ~).
#
# The ~ ~ ~ resolves to the armor stand's world position because
# the calling execute chain set position with `at @s` on the stand.
# Switching executor to the player with `as @a[...]` does NOT reset
# the position — it remains at the stand. So `teleport @s ~ ~ ~`
# moves the player to the stand's feet. This runs once per tick,
# so players cannot escape regardless of client-side movement speed.
# ─────────────────────────────────────────────────────────────────

scoreboard players operation $freeze_tp dl.tmp = @s dl.freeze_id
execute as @a[tag=datalib.frozen] if score @s datalib.pid = $freeze_tp dl.tmp run teleport @s ~ ~ ~
