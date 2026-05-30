# ─────────────────────────────────────────────────────────────────
# datalib:world/get_time
# Compatible with 26.1+ World Clocks (minecraft:overworld)
#
# OUTPUT:
# datalib:output.daytime → in-day time (0-23999)
# datalib:output.total → total world age (gametime)
# datalib:output.day → current day number
# ─────────────────────────────────────────────────────────────────

execute store result storage datalib:output daytime int 1 run time of minecraft:overworld query day
execute store result storage datalib:output total int 1 run time query gametime
execute store result storage datalib:output day int 1 run time of minecraft:overworld query day repetition

# Debug (optional)
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"world/get_time ","color":"aqua"},{"text":"day=","color":"gray"},{"storage":"datalib:output","nbt":"day","color":"green"},{"text":" daytime=","color":"gray"},{"storage":"datalib:output","nbt":"daytime","color":"green"},{"text":" total=","color":"gray"},{"storage":"datalib:output","nbt":"total","color":"green"}]
