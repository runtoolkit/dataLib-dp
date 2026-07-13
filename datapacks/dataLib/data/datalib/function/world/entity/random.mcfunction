# ─────────────────────────────────────────────────────────────────
# datalib:world/entity/random
# Selects ONE random entity matching the given type and tag and
# runs the given function as that entity (at its position).
# If no matching entity exists, nothing happens.
#
# Uses /random value (available since 1.20.2) to pick a random
# index, then dispatches via sequential dl.rnd_idx assignment.
# This gives a true uniform distribution across matching entities.
#
# INPUT : $(type) → entity type (e.g. "minecraft:zombie")
#         $(tag)  → entity tag to match
#         $(func) → function to run as the selected entity
#
# EXAMPLE:
#   function datalib:world/entity/random {type:"minecraft:zombie",tag:"mob.active",func:"mypack:reward"}
# ─────────────────────────────────────────────────────────────────

# Step 1 — count all matching entities
scoreboard players set $rnd_n dl.tmp 0
$execute as @e[type=$(type),tag=$(tag)] run scoreboard players add $rnd_n dl.tmp 1

# No entities → nothing to do
execute if score $rnd_n dl.tmp matches 0 run return 0

# Step 2 — assign sequential dl.rnd_idx to each matching entity
#           (random_assign runs AS each entity to maintain counter state)
scoreboard players set $rnd_i dl.tmp 0
$execute as @e[type=$(type),tag=$(tag)] run function datalib:core/internal/world/entity/random_assign

# Step 3 — compute max = count-1, store for the dispatch macro
scoreboard players remove $rnd_n dl.tmp 1
execute store result storage datalib:engine _rnd.max int 1 run scoreboard players get $rnd_n dl.tmp
$data modify storage datalib:engine _rnd.func set value "$(func)"
$data modify storage datalib:engine _rnd.type set value "$(type)"
$data modify storage datalib:engine _rnd.tag set value "$(tag)"

# Step 4 — roll /random value 0..max and run func as the winner
function datalib:core/internal/world/entity/random_dispatch with storage datalib:engine _rnd

# Cleanup
data remove storage datalib:engine _rnd

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/random ","color":"aqua"},{"text":"$(type)","color":"aqua"},{"text":" [$(tag)]","color":"gray"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
