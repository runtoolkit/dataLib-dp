scoreboard players set $ftgl dl.tmp 0
$execute if data storage datalib:engine flags.$(key) run scoreboard players set $ftgl dl.tmp 1

$execute if score $ftgl dl.tmp matches 1 run data remove storage datalib:engine flags.$(key)
execute if score $ftgl dl.tmp matches 1 run data modify storage datalib:output result set value 0b

$execute if score $ftgl dl.tmp matches 0 run data modify storage datalib:engine flags.$(key) set value 1b
execute if score $ftgl dl.tmp matches 0 run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"flag/toggle ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
