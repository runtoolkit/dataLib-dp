# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/format_coords
# Stores three integer coordinates in datalib:output and exposes
# them for use in tellraw components.
#
#  Input : $(x) → X coordinate (integer)
#          $(y) → Y coordinate (integer)
#          $(z) → Z coordinate (integer)
#
# Output: datalib:output x   → X int
#         datalib:output y   → Y int
#         datalib:output z   → Z int
#
# USAGE — embed the stored values directly in a tellraw:
#   function datalib:systems/string/format_coords {x:100,y:64,z:-200}
#   tellraw @a ["",
#     {"text":"(","color":"gray"},
#     {"storage":"datalib:output","nbt":"x","color":"green"},
#     {"text":", ","color":"gray"},
#     {"storage":"datalib:output","nbt":"y","color":"green"},
#     {"text":", ","color":"gray"},
#     {"storage":"datalib:output","nbt":"z","color":"green"},
#     {"text":")","color":"gray"}
#   ]
#   → (100, 64, -200)
#
# NOTE: datalib:output is shared — copy x/y/z to your own storage
#       before making other datalib calls if you need them later.
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $fc_x dl.tmp $(x)
$scoreboard players set $fc_y dl.tmp $(y)
$scoreboard players set $fc_z dl.tmp $(z)

execute store result storage datalib:output x int 1 run scoreboard players get $fc_x dl.tmp
execute store result storage datalib:output y int 1 run scoreboard players get $fc_y dl.tmp
execute store result storage datalib:output z int 1 run scoreboard players get $fc_z dl.tmp

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"string/format_coords ","color":"aqua"},{"text":"(","color":"#555555"},{"storage":"datalib:output","nbt":"x","color":"#aaffaa"},{"text":", ","color":"#555555"},{"storage":"datalib:output","nbt":"y","color":"#aaffaa"},{"text":", ","color":"#555555"},{"storage":"datalib:output","nbt":"z","color":"#aaffaa"},{"text":")","color":"#555555"}]
