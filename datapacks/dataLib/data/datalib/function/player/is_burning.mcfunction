# ─────────────────────────────────────────────────────────────────
# datalib:player/is_burning
# Checks whether a named player is currently on fire.
# Uses the datalib:is_burning predicate (entity_flags).
#
# INPUT : $(player) → player name
# OUTPUT: datalib:output result → 1b if burning, 0b otherwise
# datalib:output found → 1b if player online, 0b otherwise
#
# EXAMPLE:
# function datalib:player/is_burning {player:"Steve"}
# → datalib:output result = 1b
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output found set value 0b
data modify storage datalib:output result set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage datalib:output found set value 1b
$execute as @a[name=$(player),limit=1] if predicate datalib:is_burning run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/is_burning ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]