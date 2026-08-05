# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/lcm
# EKOK (LCM) hesaplar: lcm(a,b) = |a*b| / gcd(a,b)
#  Input : $(a), $(b)          → integers
# Output: datalib:output result → LCM(a, b)
# NOTE : Overflow risk — result may exceed INT_MAX for large inputs.
#
# Example:
# data modify storage datalib:input a set value 12
# data modify storage datalib:input b set value 8
# function datalib:systems/math/lcm with storage datalib:input {}
# # datalib:output result = 24
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $lcm_a dl.tmp $(a)
$scoreboard players set $lcm_b dl.tmp $(b)

# Zero check
execute if score $lcm_a dl.tmp matches 0 run data modify storage datalib:output result set value 0
execute if score $lcm_a dl.tmp matches 0 run return 0
execute if score $lcm_b dl.tmp matches 0 run data modify storage datalib:output result set value 0
execute if score $lcm_b dl.tmp matches 0 run return 0

# Absolute value
scoreboard players set $lcm_neg dl.tmp -1
execute if score $lcm_a dl.tmp matches ..-1 run scoreboard players operation $lcm_a dl.tmp *= $lcm_neg dl.tmp
execute if score $lcm_b dl.tmp matches ..-1 run scoreboard players operation $lcm_b dl.tmp *= $lcm_neg dl.tmp

# Compute GCD (lcm_a, lcm_b share gcd_a, gcd_b variables)
scoreboard players operation $gcd_a dl.tmp = $lcm_a dl.tmp
scoreboard players operation $gcd_b dl.tmp = $lcm_b dl.tmp
function datalib:core/internal/systems/math/gcd_loop

# lcm = (a / gcd) * b (divide first to prevent overflow)
scoreboard players operation $lcm_a dl.tmp /= $gcd_a dl.tmp
scoreboard players operation $lcm_a dl.tmp *= $lcm_b dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $lcm_a dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/lcm ","color":"aqua"},{"text":"($(a),$(b)) → ","color":"gray"},{"plain":true ,"storage":"datalib:output","nbt":"result","color":"green"}]
