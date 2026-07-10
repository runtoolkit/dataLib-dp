# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/mul_div
# Computes floor(a * b / c) without 32-bit integer overflow.
# Uses the identity: floor(a*b/c) = (a/c)*b + (a%c)*b/c
# This avoids overflow when a*b would exceed ±2147483647.
#  Input : $(a), $(b), $(c)   → integers; c must not be 0
# Output: datalib:output result → floor(a * b / c)
#
# Note: if (a % c) * b still overflows (e.g. huge b with c=1),
#       the result is clamped by Java's 32-bit signed wrapping.
#       For those cases, reduce inputs before calling.
#
# Example:
# data modify storage datalib:input a set value 1000000
# data modify storage datalib:input b set value 1000000
# data modify storage datalib:input c set value 500000
# function datalib:systems/math/mul_div with storage datalib:input {}
# # datalib:output result = 2000000
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $md_a dl.tmp $(a)
$scoreboard players set $md_b dl.tmp $(b)
$scoreboard players set $md_c dl.tmp $(c)

# Guard: c = 0 → undefined, return 0
execute if score $md_c dl.tmp matches 0 run data modify storage datalib:output result set value 0
execute if score $md_c dl.tmp matches 0 run return 0

# q = a / c  (integer quotient)
scoreboard players operation $md_q dl.tmp = $md_a dl.tmp
scoreboard players operation $md_q dl.tmp /= $md_c dl.tmp

# r = a % c  (remainder, Java truncated — may be negative)
scoreboard players operation $md_r dl.tmp = $md_a dl.tmp
scoreboard players operation $md_r dl.tmp %= $md_c dl.tmp

# result = q * b  +  r * b / c
scoreboard players operation $md_q dl.tmp *= $md_b dl.tmp
scoreboard players operation $md_r dl.tmp *= $md_b dl.tmp
scoreboard players operation $md_r dl.tmp /= $md_c dl.tmp
scoreboard players operation $md_q dl.tmp += $md_r dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $md_q dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/mul_div ","color":"aqua"},{"text":"($(a)*$(b)/$(c)) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
