# datalib:player/is_flying
# Checks whether the named player is currently flying (creative/spectator flight or elytra).
# Params: player
# Output: datalib:output result = 1b (flying) or 0b (not flying / not found)
# datalib:output found = 1b if player exists online, else 0b

data modify storage datalib:output result set value 0b
data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage datalib:output found set value 1b
$execute as @a[name=$(player),limit=1] if data entity @s {abilities:{flying:1b}} run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/is_flying ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]