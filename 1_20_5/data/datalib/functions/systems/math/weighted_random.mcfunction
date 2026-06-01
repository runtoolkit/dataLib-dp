$scoreboard players set $wr_total dl.tmp $(total)

execute if score $wr_total dl.tmp matches ..0 run data modify storage datalib:output result set value -1
execute if score $wr_total dl.tmp matches ..0 run return 0

# Draw random in range 0..total-1
data modify storage datalib:input min set value 0
scoreboard players remove $wr_total dl.tmp 1
execute store result storage datalib:input max int 1 run scoreboard players get $wr_total dl.tmp
function datalib:systems/math/random with storage datalib:engine {}

execute store result score $wr_roll dl.tmp run data get storage datalib:output result
execute store result storage datalib:output roll int 1 run scoreboard players get $wr_roll dl.tmp

data modify storage datalib:output result set value -1
scoreboard players set $wr_done dl.tmp 0

# Cumulative threshold check
$scoreboard players set $wr_acc dl.tmp $(w0)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 0
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w1)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 1
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w2)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 2
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w3)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 3
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w4)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 4
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w5)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 5
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w6)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 6
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w7)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 7
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w8)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 8
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$scoreboard players add $wr_acc dl.tmp $(w9)
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run data modify storage datalib:output result set value 9
execute if score $wr_done dl.tmp matches 0 run execute if score $wr_roll dl.tmp < $wr_acc dl.tmp run scoreboard players set $wr_done dl.tmp 1

$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/weighted_random ","color":"aqua"},{"text":"total=$(total) roll=","color":"gray"},{"score":{"name":"$wr_roll","objective":"dl.tmp"},"color":"yellow"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]}
