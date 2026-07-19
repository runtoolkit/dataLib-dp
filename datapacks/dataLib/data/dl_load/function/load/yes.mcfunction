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
# dl_load:loader/scoreboards runs and recreates its own objectives.

# Guard: no gate open
execute unless score #pending dl.load matches 1 run return 0

# Guard: already confirmed (double-call protection)
execute if score #confirmed dl.load matches 1 run return 0

# Mark confirmed — close window
scoreboard players set #confirmed dl.load 1
scoreboard players set #pending dl.load 0

# Cancel auto-cancel timeout
schedule clear dl_load:timeout

# Announce via tellraw — no marker entity needed.
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Load CONFIRMED","color":"green","bold":true},{"text":" by operator. Initializing dataLib...","color":"gray"}]

# Tear down gate scoreboard before load pipeline touches scoreboards
scoreboard players reset #pending dl.load
scoreboard players reset #confirmed dl.load
scoreboard players reset #cancelled dl.load
scoreboard objectives remove dl.load

# Fire the actual load pipeline
# 1-tick delay gives scoreboard removal a clean tick boundary before
# dl_load:loader/scoreboards recreates its objectives
schedule function dl_load:load/all 1t replace
