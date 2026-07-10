# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/format_number
# Converts large numbers to readable abbreviations.
#  Input : $(value) → integer
# Output: datalib:output text → abbreviated text (storage string)
# datalib:output value → original value
# datalib:output suffix → k / M / B / "" suffix
# datalib:output short → abbreviated integer part
#
# Examples:
# 500 → "500"
# 1500 → "1.5k"
# 1000000 → "1M"
# 2500000 → "2.5M"
# 1000000000 → "1B"
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $fn_v dl.tmp $(value)
execute store result storage datalib:output value int 1 run scoreboard players get $fn_v dl.tmp

# < 1000 → plain number
execute if score $fn_v dl.tmp matches ..999 run data modify storage datalib:output suffix set value ""
execute if score $fn_v dl.tmp matches ..999 run execute store result storage datalib:output short int 1 run scoreboard players get $fn_v dl.tmp
execute if score $fn_v dl.tmp matches ..999 run return 0

# 1000 – 999999 → k
execute if score $fn_v dl.tmp matches 1000..999999 run data modify storage datalib:output suffix set value "k"
execute if score $fn_v dl.tmp matches 1000..999999 run scoreboard players set $fn_div dl.tmp 100
execute if score $fn_v dl.tmp matches 1000..999999 run scoreboard players operation $fn_v dl.tmp /= $fn_div dl.tmp
execute if score $fn_v dl.tmp matches 1000..999999 run execute store result storage datalib:output short int 1 run scoreboard players get $fn_v dl.tmp
execute if score $fn_v dl.tmp matches 1000..999999 run return 0

# 1_000_000 – 999_999_999 → M
execute if score $fn_v dl.tmp matches 1000000..999999999 run data modify storage datalib:output suffix set value "M"
execute if score $fn_v dl.tmp matches 1000000..999999999 run scoreboard players set $fn_div dl.tmp 100000
execute if score $fn_v dl.tmp matches 1000000..999999999 run scoreboard players operation $fn_v dl.tmp /= $fn_div dl.tmp
execute if score $fn_v dl.tmp matches 1000000..999999999 run execute store result storage datalib:output short int 1 run scoreboard players get $fn_v dl.tmp
execute if score $fn_v dl.tmp matches 1000000..999999999 run return 0

# >= 1_000_000_000 → B
execute if score $fn_v dl.tmp matches 1000000000.. run data modify storage datalib:output suffix set value "B"
execute if score $fn_v dl.tmp matches 1000000000.. run scoreboard players set $fn_div dl.tmp 100000000
execute if score $fn_v dl.tmp matches 1000000000.. run scoreboard players operation $fn_v dl.tmp /= $fn_div dl.tmp
execute if score $fn_v dl.tmp matches 1000000000.. run execute store result storage datalib:output short int 1 run scoreboard players get $fn_v dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"string/format_number ","color":"aqua"},{"text":"$(value) → ","color":"gray"},{"storage":"datalib:output","nbt":"short","color":"green"},{"storage":"datalib:output","nbt":"suffix","color":"green"}]
