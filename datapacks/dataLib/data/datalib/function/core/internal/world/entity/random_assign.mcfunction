# ─────────────────────────────────────────────────────────────────
# datalib:world/entity/internal/random_assign  [INTERNAL]
# Called via "execute as @e[...] run function ..." — runs as each
# matching entity in sequence.
#
# Copies the current counter ($rnd_i dl.tmp) into this entity's
# dl.rnd_idx score, then increments the counter.
# Because each function call runs to completion before the next
# entity is processed, $rnd_i increments correctly.
#
# Result: entity 1 → dl.rnd_idx=0, entity 2 → 1, entity 3 → 2 …
# ─────────────────────────────────────────────────────────────────

scoreboard players operation @s dl.rnd_idx = $rnd_i dl.tmp
scoreboard players add $rnd_i dl.tmp 1
