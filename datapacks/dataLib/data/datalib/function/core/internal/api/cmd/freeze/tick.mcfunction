# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/freeze/internal/tick  [INTERNAL — runs via on_tick]
# Hooked into #datalib:events/on_tick (called every game tick).
#
# Early-exit if no frozen players exist — zero cost when the
# freeze system is idle.
#
# For each anchor stand: switch execution position to the stand,
# then delegate to anchor_tp which identifies and teleports the
# matching frozen player back to that position.
# ─────────────────────────────────────────────────────────────────

# Fast exit — no frozen players, nothing to do
execute unless entity @a[tag=datalib.frozen] run return 0

# Iterate anchor stands and teleport their linked players back
execute as @e[tag=datalib.freeze_anchor] at @s run function datalib:core/internal/api/cmd/freeze/anchor_tp
