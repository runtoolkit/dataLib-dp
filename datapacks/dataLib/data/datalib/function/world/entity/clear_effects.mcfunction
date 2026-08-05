# ─────────────────────────────────────────────────────────────────
# datalib:world/entity/clear_effects
# Clears all active potion effects from entities matching type+tag.
#
# INPUT : $(type) → entity type selector (e.g. "minecraft:player")
#         $(tag)  → entity tag filter
# ─────────────────────────────────────────────────────────────────

$effect clear @e[type=$(type),tag=$(tag)]
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/clear_effects ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(type)[tag=$(tag)]","color":"aqua"}]
