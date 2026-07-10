$scoreboard players set $dvm_v dl.tmp $(value)
$scoreboard players set $dvm_d dl.tmp $(divisor)

execute if score $dvm_d dl.tmp matches ..0 run data modify storage datalib:output quotient set value 0
execute if score $dvm_d dl.tmp matches ..0 run data modify storage datalib:output remainder set value 0
execute if score $dvm_d dl.tmp matches ..0 run return 0

scoreboard players operation $dvm_q dl.tmp = $dvm_v dl.tmp
scoreboard players operation $dvm_q dl.tmp /= $dvm_d dl.tmp
execute store result storage datalib:output quotient int 1 run scoreboard players get $dvm_q dl.tmp

scoreboard players operation $dvm_v dl.tmp %= $dvm_d dl.tmp
execute if score $dvm_v dl.tmp matches ..-1 run scoreboard players operation $dvm_v dl.tmp += $dvm_d dl.tmp
execute store result storage datalib:output remainder int 1 run scoreboard players get $dvm_v dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/divmod ","color":"aqua"},{"text":"($(value)/$(divisor))","color":"gray"},{"text":" → ","color":"#555555"},{"text":"q=","color":"gray"},{"storage":"datalib:output","nbt":"quotient","color":"green"},{"text":" r=","color":"gray"},{"storage":"datalib:output","nbt":"remainder","color":"green"}]
