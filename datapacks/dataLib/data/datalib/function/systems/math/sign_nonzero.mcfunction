# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/sign_nonzero
# Returns -1 for negative, +1 for zero-or-positive.
# Useful when you need a non-zero multiplier (e.g. direction vectors).
#
# INPUT : $(value) → integer
# OUTPUT: datalib:output result → 1 or -1
#
# EXAMPLE:
# function datalib:systems/math/sign_nonzero {value:-5}
# → datalib:output result = -1
# function datalib:systems/math/sign_nonzero {value:0}
# → datalib:output result = 1
# ─────────────────────────────────────────────────────────────────

$scoreboard players set #snz_v dl.tmp $(value)
data modify storage datalib:output result set value 1
execute if score #snz_v dl.tmp matches ..-1 run data modify storage datalib:output result set value -1
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/sign_nonzero ","color":"aqua"},{"text":"$(value) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
