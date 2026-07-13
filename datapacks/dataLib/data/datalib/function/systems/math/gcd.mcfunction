# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/gcd
# Computes GCD using the Euclidean algorithm.
#  Input : $(a), $(b)          → integers (may be negative)
# Output: datalib:output result → GCD(|a|, |b|)
#
# Example:
# data modify storage datalib:input a set value 48
# data modify storage datalib:input b set value 18
# function datalib:systems/math/gcd with storage datalib:input {}
# # datalib:output result = 6
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $gcd_a dl.tmp $(a)
$scoreboard players set $gcd_b dl.tmp $(b)

# Take absolute value
scoreboard players set $gcd_neg dl.tmp -1
execute if score $gcd_a dl.tmp matches ..-1 run scoreboard players operation $gcd_a dl.tmp *= $gcd_neg dl.tmp
execute if score $gcd_b dl.tmp matches ..-1 run scoreboard players operation $gcd_b dl.tmp *= $gcd_neg dl.tmp

# b=0 → result is a
execute if score $gcd_b dl.tmp matches 0 run execute store result storage datalib:output result int 1 run scoreboard players get $gcd_a dl.tmp
execute if score $gcd_b dl.tmp matches 0 run return 0

# Euclidean loop (inner function)
function datalib:core/internal/systems/math/gcd_loop

execute store result storage datalib:output result int 1 run scoreboard players get $gcd_a dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/gcd ","color":"aqua"},{"text":"($(a),$(b)) → ","color":"gray"},{"plain":true ,"storage":"datalib:output","nbt":"result","color":"green"}]
