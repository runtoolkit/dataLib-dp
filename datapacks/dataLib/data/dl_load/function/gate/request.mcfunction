# dl_load:gate/request
# Generic dangerous-command confirmation gate — request side.
#
# CALLER PROTOCOL
# ---------------
# Before calling this function, the caller MUST write a pending_gate
# compound to datalib:engine storage describing the action to confirm:
#
#   data modify storage datalib:engine pending_gate set value {type:"ban", player:"...", reason:"..."}
#   function dl_load:gate/request
#
# This function then:
#   1. Opens the dl.gate scoreboard window
#   2. Broadcasts a clickable confirmation prompt via tellraw
#   3. Schedules a 30-second auto-cancel
#
# CONFIRMING:  /function dl_load:gate/yes  (or click [Confirm])
# CANCELLING:  /function dl_load:gate/no   (or click [Cancel])
#
# If another gate is already pending, this call is silently dropped to
# prevent multiple dangerous commands from racing in multiplayer.

# Drop silently if a gate is already open (multiplayer safety)
scoreboard objectives add dl.gate dummy
execute if score #pending dl.gate matches 1 run return 0

# Open the gate window
scoreboard players set #pending dl.gate 0
scoreboard players set #confirmed dl.gate 0
scoreboard players set #pending dl.gate 1

# Broadcast via tellraw — clickable buttons, no marker entity needed.
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Dangerous command pending","color":"yellow","bold":true},{"text":" — awaiting confirmation.","color":"gray"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"[Confirm]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:gate/yes"}},{"text":"   ","color":"gray"},{"text":"[Cancel]","color":"red","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:gate/no"}}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Auto-cancel fires in 30 seconds.","color":"gray"}]

# Schedule 30-second auto-cancel for dangerous commands
schedule function dl_load:gate/timeout 30s replace
