# ─────────────────────────────────────────────────────────────────
# datalib:world/time_phase
# Time phase detection compatible with 26.1+ World Clocks
#
# OUTPUT:
# datalib:output.phase → "dawn" / "day" / "dusk" / "night"
# datalib:output.daytime → raw daytime tick (0–23999)
# datalib:output.is_day → 1b (daytime)
# datalib:output.is_night → 1b (nighttime)
# datalib:output.is_dawn → 1b (dawn)
# datalib:output.is_dusk → 1b (dusk)
# ─────────────────────────────────────────────────────────────────

# Get in-day time (26.1+ correct syntax)
execute store result score $tp_t dl.tmp run time of minecraft:overworld query day

# Write raw daytime to storage
execute store result storage datalib:output daytime int 1 run scoreboard players get $tp_t dl.tmp

# Reset boolean flags
data modify storage datalib:output is_day set value 0b
data modify storage datalib:output is_night set value 0b
data modify storage datalib:output is_dawn set value 0b
data modify storage datalib:output is_dusk set value 0b

# Set boolean values
execute if score $tp_t dl.tmp matches 0..12999 run data modify storage datalib:output is_day set value 1b
execute if score $tp_t dl.tmp matches 13000..23999 run data modify storage datalib:output is_night set value 1b
execute if score $tp_t dl.tmp matches 0..999 run data modify storage datalib:output is_dawn set value 1b
execute if score $tp_t dl.tmp matches 12000..13799 run data modify storage datalib:output is_dusk set value 1b

# Determine phase name
execute if score $tp_t dl.tmp matches 0..999 run data modify storage datalib:output phase set value "dawn"
execute if score $tp_t dl.tmp matches 1000..11999 run data modify storage datalib:output phase set value "day"
execute if score $tp_t dl.tmp matches 12000..13799 run data modify storage datalib:output phase set value "dusk"
execute if score $tp_t dl.tmp matches 13800..23999 run data modify storage datalib:output phase set value "night"

# Debug message (optional)
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"world/time_phase ","color":"aqua"},{"storage":"datalib:output","nbt":"phase","color":"green"},{"text":" t=","color":"gray"},{"storage":"datalib:output","nbt":"daytime","color":"white"}]
