execute store result score $ce_base dl.tmp run scoreboard players get $epoch datalib.time
scoreboard players operation $ce_exp dl.tmp = $ce_base dl.tmp

$execute if data storage datalib:engine cooldowns.$(player).$(key) run execute store result score $ce_exp dl.tmp run data get storage datalib:engine cooldowns.$(player).$(key)

execute if score $ce_exp dl.tmp <= $ce_base dl.tmp run scoreboard players operation $ce_exp dl.tmp = $ce_base dl.tmp

$scoreboard players set $ce_amt dl.tmp $(amount)
scoreboard players operation $ce_exp dl.tmp += $ce_amt dl.tmp

$execute store result storage datalib:engine cooldowns.$(player).$(key) int 1 run scoreboard players get $ce_exp dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/extend ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" +$(amount)t","color":"green"},{"text":" → exp=","color":"#555555"},{"score":{"name":"$ce_exp","objective":"dl.tmp"},"color":"yellow"}]
