# ─────────────────────────────────────────────────────────────────
# datalib:world/entity/set_health
# Sets the health of entities matching type+tag by applying
# instant_health or instant_damage effects calibrated to the target amount.
# Note: direct NBT entity Health write was removed in 1.20.5.
# This implementation uses instant_health amplifier to fill HP;
# it first applies instant_damage level 255 (kills/zeros HP) then
# instant_health at the desired level to restore to target amount.
#
# amount → instant_health amplifier level (0-based; level 1 = +2 HP, level N = +2*(N+1) HP)
# To set exactly N half-hearts: amplifier = (N / 2) - 1, clamped to [0, 255].
#
# INPUT : $(type)   → entity type (e.g. "minecraft:player")
#         $(tag)    → entity tag filter
#         $(amount) → target amplifier level for instant_health (int 0–255)
# ─────────────────────────────────────────────────────────────────

$effect give @e[type=$(type),tag=$(tag)] minecraft:instant_damage 1 255 true
$effect give @e[type=$(type),tag=$(tag)] minecraft:instant_health 1 $(amount) true
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/set_health ","color":"aqua"},{"text":" → amplifier=$(amount) on ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
