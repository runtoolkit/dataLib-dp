# ─────────────────────────────────────────────────────────────────
# datalib:player/get_air
# Returns the current air supply of the named player.
# Air ranges from 0 (drowning) to 300 (full) in ticks.
#
# INPUT : $(player) → player name
# OUTPUT: datalib:output result → air ticks (int, 0–300)
#         datalib:output found  → 1b if player online, 0b otherwise
#
# EXAMPLE:
#   function datalib:player/get_air {player:"Steve"}
#   → datalib:output result = 300
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage datalib:output found set value 1b
$execute as @a[name=$(player),limit=1] store result storage datalib:output result int 1 run data get entity @s Air
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/get_air ","color":"aqua"},{"text":"$(player) → air=","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
