# ─────────────────────────────────────────────────────────────────
# datalib:world/entity/internal/random_dispatch  [INTERNAL — MACRO]
# Called with "with storage datalib:engine _rnd".
#
# Rolls /random value 0..$(max) to pick a uniform random index,
# then runs the target function as the entity whose dl.rnd_idx
# matches the rolled value.
#
# MACRO ARGS (from datalib:engine _rnd compound):
#   $(max)  → count - 1  (upper bound for random value, inclusive)
#   $(func) → function to dispatch
#   $(type) → entity type filter (same as outer call)
#   $(tag)  → entity tag filter  (same as outer call)
# ─────────────────────────────────────────────────────────────────

# Roll a random integer in [0, max] using the 1.20.2+ /random command
$execute store result score $rnd_pick dl.tmp run random value 0..$(max)

# Dispatch: run func as the entity whose index was rolled
$data modify storage datalib:engine _dispatch.func set value "$(func)"
$execute as @e[type=$(type),tag=$(tag)] if score @s dl.rnd_idx = $rnd_pick dl.tmp at @s run function #datalib:internal/dispatch
