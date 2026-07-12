scoreboard players set $st_tog dl.tmp 0
$execute if data storage datalib:engine {states:{$(player):"$(on)"}} run scoreboard players set $st_tog dl.tmp 1

$execute if score $st_tog dl.tmp matches 1 run data modify storage datalib:engine states.$(player) set value "$(off)"
$execute if score $st_tog dl.tmp matches 0 run data modify storage datalib:engine states.$(player) set value "$(on)"

data remove storage datalib:output result
$data modify storage datalib:output result set from storage datalib:engine states.$(player)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"state/toggle ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" (","color":"#555555"},{"text":"$(on)","color":"gray"},{"text":"↔","color":"#555555"},{"text":"$(off)","color":"gray"},{"text":") → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
