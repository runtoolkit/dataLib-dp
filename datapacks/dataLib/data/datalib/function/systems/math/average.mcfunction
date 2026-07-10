# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/average
# Computes the integer average of up to 8 values.
#  Input : $(v0)..(v7)  → integer values
#          $(count)     → how many values (1-8)
# Output: datalib:output result → floor(sum / count)
#
# Example:
# data modify storage datalib:input v0 set value 10
# data modify storage datalib:input v1 set value 20
# data modify storage datalib:input v2 set value 30
# data modify storage datalib:input count set value 3
# function datalib:systems/math/average with storage datalib:input {}
# # datalib:output result = 20
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $avg_c dl.tmp $(count)

execute if score $avg_c dl.tmp matches ..0 run data modify storage datalib:output result set value 0
execute if score $avg_c dl.tmp matches ..0 run return 0

$scoreboard players set $avg_s dl.tmp $(v0)
$execute if score $avg_c dl.tmp matches 2.. run scoreboard players add $avg_s dl.tmp $(v1)
$execute if score $avg_c dl.tmp matches 3.. run scoreboard players add $avg_s dl.tmp $(v2)
$execute if score $avg_c dl.tmp matches 4.. run scoreboard players add $avg_s dl.tmp $(v3)
$execute if score $avg_c dl.tmp matches 5.. run scoreboard players add $avg_s dl.tmp $(v4)
$execute if score $avg_c dl.tmp matches 6.. run scoreboard players add $avg_s dl.tmp $(v5)
$execute if score $avg_c dl.tmp matches 7.. run scoreboard players add $avg_s dl.tmp $(v6)
$execute if score $avg_c dl.tmp matches 8.. run scoreboard players add $avg_s dl.tmp $(v7)

scoreboard players operation $avg_s dl.tmp /= $avg_c dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $avg_s dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/average ","color":"aqua"},{"text":"count=$(count) ","color":"gray"},{"text":"→ ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
