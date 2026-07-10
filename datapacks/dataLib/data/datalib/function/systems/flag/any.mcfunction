# ─────────────────────────────────────────────────────────────────
# datalib:systems/flag/any
# Checks whether ANY of two flags is set.
# Returns 1b if at least one of key_a or key_b is set, 0b otherwise.
# For three or more flags, chain calls or use flag/get on each.
#
# INPUT : $(key_a) → first flag key
#         $(key_b) → second flag key
# OUTPUT: datalib:output result → 1b if either flag set, 0b if neither
# datalib:output result_a → 1b if key_a set, 0b otherwise
# datalib:output result_b → 1b if key_b set, 0b otherwise
#
# EXAMPLE:
# function datalib:systems/flag/any {key_a:"pvp_enabled",key_b:"war_active"}
# → datalib:output result = 1b (if either is set)
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output result_a set value 0b
data modify storage datalib:output result_b set value 0b
data modify storage datalib:output result set value 0b

scoreboard players set #fany_a dl.tmp 0
scoreboard players set #fany_b dl.tmp 0

$execute if data storage datalib:engine flags.$(key_a) run scoreboard players set #fany_a dl.tmp 1
$execute if data storage datalib:engine flags.$(key_b) run scoreboard players set #fany_b dl.tmp 1

execute if score #fany_a dl.tmp matches 1 run data modify storage datalib:output result_a set value 1b
execute if score #fany_b dl.tmp matches 1 run data modify storage datalib:output result_b set value 1b

scoreboard players operation #fany_a dl.tmp += #fany_b dl.tmp
execute if score #fany_a dl.tmp matches 1.. run data modify storage datalib:output result set value 1b

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"flag/any ","color":"aqua"},{"text":"$(key_a)|$(key_b) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
