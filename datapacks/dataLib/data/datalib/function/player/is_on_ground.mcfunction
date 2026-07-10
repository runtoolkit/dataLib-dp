# ─────────────────────────────────────────────────────────────────
# datalib:player/is_on_ground
# Checks whether a named player is currently on the ground.
# Uses the datalib:is_on_ground predicate (entity_flags).
#
# INPUT : $(player) → player name
# OUTPUT: datalib:output result → 1b if on ground, 0b otherwise
# datalib:output found → 1b if player online, 0b otherwise
#
# EXAMPLE:
# function datalib:player/is_on_ground {player:"Steve"}
# → datalib:output result = 1b
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output found set value 0b
data modify storage datalib:output result set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage datalib:output found set value 1b
$execute as @a[name=$(player),limit=1] if predicate datalib:is_on_ground run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/is_on_ground ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]