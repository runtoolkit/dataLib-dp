# dl_load:load/yes
# Admin confirmed DL load. Triggers the full initialization pipeline.
#
# GUARDS
# ------
#   - Gate must be open (#pending dl.load == 1)
#   - Already-confirmed calls are no-ops (idempotent)
#   - If called with no gate pending, silently returns 0
#
# WHAT HAPPENS
# ------------
#   1. Mark confirmed, close the pending window
#   2. Cancel the 5-minute timeout schedule
#   3. Tear down the dl.load objective (not needed after this point)
#   4. Schedule dl_load:load/all at t+1 (clean tick boundary)
#
# The 1-tick delay lets the scoreboard objective removal settle before
# dl_load:load/scoreboards runs and recreates its own objectives.

# Guard: no gate open
execute unless score #pending dl.load matches 1 run return 0

# Guard: already confirmed (double-call protection)
execute if score #confirmed dl.load matches 1 run return 0

# Mark confirmed — close window
scoreboard players set #confirmed dl.load 1
scoreboard players set #pending dl.load 0

# Cancel auto-cancel timeout
schedule clear dl_load:timeout

# Announce via marker (safe on all MC versions, no player context needed)
summon minecraft:marker ~ ~ ~ {Tags:["datalib.gate_yes"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.gate_yes,limit=1] run say [DL GATE] Load CONFIRMED by operator. Initializing dataLib...
execute as @e[type=minecraft:marker,tag=datalib.gate_yes,limit=1] run kill @s

# Tear down gate scoreboard before load pipeline touches scoreboards
scoreboard players reset #pending dl.load
scoreboard players reset #confirmed dl.load
scoreboard players reset #cancelled dl.load
scoreboard objectives remove dl.load

# Fire the actual load pipeline
# 1-tick delay gives scoreboard removal a clean tick boundary before
# dl_load:load/scoreboards recreates its objectives
schedule function dl_load:load/all 1t replace