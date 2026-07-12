# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/round
# Rounds a value to the nearest multiple of a given step.
# Integer division truncates toward zero; adding half the step before
# dividing gives standard rounding (0.5 rounds away from zero).
#
# INPUT : $(value) → integer to round
#         $(step)  → rounding step (must be > 0)
# OUTPUT: datalib:output result → rounded value
#
# EXAMPLE:
# function datalib:systems/math/round {value:37, step:10}
# → datalib:output result = 40
# function datalib:systems/math/round {value:34, step:10}
# → datalib:output result = 30
# ─────────────────────────────────────────────────────────────────

$scoreboard players set #rnd_v dl.tmp $(value)
$scoreboard players set #rnd_s dl.tmp $(step)

execute if score #rnd_s dl.tmp matches ..0 run return fail

# add half step for rounding (integer division: step=10 → half=5)
scoreboard players operation #rnd_half dl.tmp = #rnd_s dl.tmp
scoreboard players set #rnd_2 dl.tmp 2
scoreboard players operation #rnd_half dl.tmp /= #rnd_2 dl.tmp

execute if score #rnd_v dl.tmp matches 0.. run scoreboard players operation #rnd_v dl.tmp += #rnd_half dl.tmp
execute if score #rnd_v dl.tmp matches ..-1 run scoreboard players operation #rnd_v dl.tmp -= #rnd_half dl.tmp

scoreboard players operation #rnd_v dl.tmp /= #rnd_s dl.tmp
scoreboard players operation #rnd_v dl.tmp *= #rnd_s dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get #rnd_v dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/round ","color":"aqua"},{"text":"$(value) step=$(step) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
