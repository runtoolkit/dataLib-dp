# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/sum3
# Adds three integers with INT_MAX overflow guard.
#  Input : $(a), $(b), $(c)
# Output: datalib:output result → a + b + c (clamped to 2147483647)
#
# Example:
# data modify storage datalib:input a set value 100
# data modify storage datalib:input b set value 200
# data modify storage datalib:input c set value 300
# function datalib:systems/math/sum3 with storage datalib:input {}
# # datalib:output result = 600
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $s3_a dl.tmp $(a)
$scoreboard players set $s3_b dl.tmp $(b)
$scoreboard players set $s3_c dl.tmp $(c)

scoreboard players operation $s3_a dl.tmp += $s3_b dl.tmp
# Overflow clamp after first add
execute if score $s3_a dl.tmp matches 2147483647.. run scoreboard players set $s3_a dl.tmp 2147483647

scoreboard players operation $s3_a dl.tmp += $s3_c dl.tmp
# Overflow clamp after second add
execute if score $s3_a dl.tmp matches 2147483647.. run scoreboard players set $s3_a dl.tmp 2147483647

execute store result storage datalib:output result int 1 run scoreboard players get $s3_a dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/sum3 ","color":"aqua"},{"text":"($(a)+$(b)+$(c)) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
