# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/pluralize
# Stores the singular or plural form of a word based on count.
# Simple English rule: count == 1 → singular, else → plural.
#
# INPUT : $(count)    → integer count
#         $(singular) → singular form (e.g. "item")
#         $(plural)   → plural form   (e.g. "items")
# OUTPUT: datalib:output result → chosen string
# datalib:output count → original count
#
# EXAMPLE:
# function datalib:systems/string/pluralize {count:3,singular:"apple",plural:"apples"}
# → datalib:output result = "apples"
# ─────────────────────────────────────────────────────────────────

$scoreboard players set #plr_c dl.tmp $(count)
execute store result storage datalib:output count int 1 run scoreboard players get #plr_c dl.tmp

$data modify storage datalib:engine _plr_singular set value $(singular)
$data modify storage datalib:engine _plr_plural set value $(plural)

data modify storage datalib:output result set from storage datalib:engine _plr_plural
execute if score #plr_c dl.tmp matches 1 run data modify storage datalib:output result set from storage datalib:engine _plr_singular

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"string/pluralize ","color":"aqua"},{"text":"count=$(count) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
