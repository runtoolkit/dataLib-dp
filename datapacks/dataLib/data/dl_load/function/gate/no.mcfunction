# dl_load:gate/no
# Cancel the pending dangerous command.
#
# Does NOT execute the pending action. Clears pending_gate from storage.
# Idempotent — safe to call multiple times.
#
# ALSO CALLED BY: dl_load:gate/timeout (auto-cancel after 30 seconds)

# Guard: nothing pending
execute unless score #pending dl.gate matches 1 run return 0

# Close the gate window
scoreboard players set #pending dl.gate 0
scoreboard players set #confirmed dl.gate 0

# Cancel the still-pending timeout if admin called /no explicitly
schedule clear dl_load:gate/timeout

# Announce cancellation via tellraw — no marker entity needed.
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Dangerous command CANCELLED.","color":"red","bold":true},{"text":" Action was NOT executed.","color":"gray"}]

# Discard pending context
data remove storage datalib:engine pending_gate
scoreboard players reset #pending dl.gate
scoreboard players reset #confirmed dl.gate
scoreboard objectives remove dl.gate
