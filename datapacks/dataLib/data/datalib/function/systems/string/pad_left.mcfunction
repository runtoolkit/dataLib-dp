$scoreboard players set $pl_v dl.tmp $(value)
$scoreboard players set $pl_w dl.tmp $(width)

scoreboard players set $pl_neg dl.tmp -1
execute if score $pl_v dl.tmp matches ..-1 run scoreboard players operation $pl_v dl.tmp *= $pl_neg dl.tmp

scoreboard players set $pl_digits dl.tmp 1
execute if score $pl_v dl.tmp matches 10.. run scoreboard players set $pl_digits dl.tmp 2
execute if score $pl_v dl.tmp matches 100.. run scoreboard players set $pl_digits dl.tmp 3
execute if score $pl_v dl.tmp matches 1000.. run scoreboard players set $pl_digits dl.tmp 4
execute if score $pl_v dl.tmp matches 10000.. run scoreboard players set $pl_digits dl.tmp 5
execute if score $pl_v dl.tmp matches 100000.. run scoreboard players set $pl_digits dl.tmp 6
execute if score $pl_v dl.tmp matches 1000000.. run scoreboard players set $pl_digits dl.tmp 7
execute if score $pl_v dl.tmp matches 10000000.. run scoreboard players set $pl_digits dl.tmp 8

scoreboard players operation $pl_pad dl.tmp = $pl_w dl.tmp
scoreboard players operation $pl_pad dl.tmp -= $pl_digits dl.tmp

data modify storage datalib:output result set value ""

execute if score $pl_pad dl.tmp matches 1.. run data modify storage datalib:output result set value "0"
execute if score $pl_pad dl.tmp matches 2.. run data modify storage datalib:output result set value "00"
execute if score $pl_pad dl.tmp matches 3.. run data modify storage datalib:output result set value "000"
execute if score $pl_pad dl.tmp matches 4.. run data modify storage datalib:output result set value "0000"
execute if score $pl_pad dl.tmp matches 5.. run data modify storage datalib:output result set value "00000"
execute if score $pl_pad dl.tmp matches 6.. run data modify storage datalib:output result set value "000000"
execute if score $pl_pad dl.tmp matches 7.. run data modify storage datalib:output result set value "0000000"

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"string/pad_left ","color":"aqua"},{"text":"$(value) w=$(width) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"},{"text":"[NUM]","color":"#555555"}]
