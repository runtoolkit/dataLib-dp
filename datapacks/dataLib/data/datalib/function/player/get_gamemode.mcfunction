# datalib:player/get_gamemode [MACRO]
# Returns the gamemode of a named player as an integer.
#
# INPUT:  $(player) — player name
# OUTPUT: datalib:output result — 0=survival, 1=creative, 2=adventure, 3=spectator
# datalib:output name — "survival" | "creative" | "adventure" | "spectator"
# datalib:output found — 1b if player exists, 0b otherwise
#
# EXAMPLE:
# function datalib:player/get_gamemode {player:"Steve"}
# data get storage datalib:output name

data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage datalib:output found set value 1b

$execute if entity @a[name=$(player),gamemode=survival,limit=1] run data modify storage datalib:output result set value 0
$execute if entity @a[name=$(player),gamemode=creative,limit=1] run data modify storage datalib:output result set value 1
$execute if entity @a[name=$(player),gamemode=adventure,limit=1] run data modify storage datalib:output result set value 2
$execute if entity @a[name=$(player),gamemode=spectator,limit=1] run data modify storage datalib:output result set value 3

$execute if entity @a[name=$(player),gamemode=survival,limit=1] run data modify storage datalib:output name set value "survival"
$execute if entity @a[name=$(player),gamemode=creative,limit=1] run data modify storage datalib:output name set value "creative"
$execute if entity @a[name=$(player),gamemode=adventure,limit=1] run data modify storage datalib:output name set value "adventure"
$execute if entity @a[name=$(player),gamemode=spectator,limit=1] run data modify storage datalib:output name set value "spectator"

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/get_gamemode ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"storage":"datalib:output","nbt":"name","color":"green"}]