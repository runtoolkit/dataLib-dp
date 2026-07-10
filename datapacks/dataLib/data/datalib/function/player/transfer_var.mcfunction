$execute store result score $tr_f dl.tmp run data get storage datalib:engine players.$(from).$(key)
$scoreboard players set $tr_a dl.tmp $(amount)
scoreboard players operation $tr_f dl.tmp -= $tr_a dl.tmp
$execute store result storage datalib:engine players.$(from).$(key) int 1 run scoreboard players get $tr_f dl.tmp

$execute store result score $tr_t dl.tmp run data get storage datalib:engine players.$(to).$(key)
scoreboard players operation $tr_t dl.tmp += $tr_a dl.tmp
$execute store result storage datalib:engine players.$(to).$(key) int 1 run scoreboard players get $tr_t dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $tr_t dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/transfer_var ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]