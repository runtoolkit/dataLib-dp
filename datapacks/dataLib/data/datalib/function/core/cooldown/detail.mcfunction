data merge storage datalib:output {active:0b,remaining:0,expires:0}

$execute unless data storage datalib:engine cooldowns.$(player).$(key) run return 0

$execute store result score $cdd_exp dl.tmp run data get storage datalib:engine cooldowns.$(player).$(key)
execute store result storage datalib:output expires int 1 run scoreboard players get $cdd_exp dl.tmp

execute store result score $cdd_now dl.tmp run scoreboard players get $epoch datalib.time

execute if score $cdd_now dl.tmp < $cdd_exp dl.tmp run data modify storage datalib:output active set value 1b

scoreboard players operation $cdd_exp dl.tmp -= $cdd_now dl.tmp
execute if score $cdd_exp dl.tmp matches 1.. run execute store result storage datalib:output remaining int 1 run scoreboard players get $cdd_exp dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/detail ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" active=","color":"#555555"},{"storage":"datalib:output","nbt":"active","color":"green"},{"text":" rem=","color":"#555555"},{"storage":"datalib:output","nbt":"remaining","color":"green"},{"text":" exp=","color":"#555555"},{"storage":"datalib:output","nbt":"expires","color":"green"}]
