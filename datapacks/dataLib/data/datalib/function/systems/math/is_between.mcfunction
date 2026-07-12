# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/is_between
# Checks if value is in the inclusive range [min, max].
#  Input : $(value), $(min), $(max)
# Output: datalib:output result → 1b (true) or 0b (false)
#
# Example:
# data modify storage datalib:input value set value 15
# data modify storage datalib:input min set value 10
# data modify storage datalib:input max set value 20
# function datalib:systems/math/is_between with storage datalib:input {}
# # datalib:output result = 1b
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $ib_v dl.tmp $(value)
$scoreboard players set $ib_lo dl.tmp $(min)
$scoreboard players set $ib_hi dl.tmp $(max)

data modify storage datalib:output result set value 0b

execute if score $ib_v dl.tmp >= $ib_lo dl.tmp run execute if score $ib_v dl.tmp <= $ib_hi dl.tmp run data modify storage datalib:output result set value 1b

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/is_between ","color":"aqua"},{"text":"$(value) in [$(min),$(max)] → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
