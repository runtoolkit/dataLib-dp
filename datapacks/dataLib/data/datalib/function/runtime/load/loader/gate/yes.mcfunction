# datalib:runtime/load/loader/gate/yes
# Execute the pending dangerous command after admin confirmation.
#
# Reads the pending_gate compound from datalib:engine storage and dispatches
# to the correct executor based on the 'type' field.
#
# SUPPORTED TYPES
# ---------------
#   "ban"     → datalib:runtime/load/loader/gate/exec/ban       (datalib: player, reason)
#   "ban_ip"  → datalib:runtime/load/loader/gate/exec/ban_ip    (datalib: player, reason)
#   "kick"    → datalib:runtime/load/loader/gate/exec/kick      (datalib: player, reason)
#   "disable" → datalib:runtime/load/loader/gate/exec/disable   (no macro params)
#
# Adding new types: write an executor in datalib:runtime/load/loader/gate/exec/, then add
# an 'execute if data' dispatch line here.

# Guard: no gate open
execute unless score #pending dl.gate matches 1 run return 0

# Guard: already confirmed (double-call protection)
execute if score #confirmed dl.gate matches 1 run return 0

# Mark confirmed, close window
scoreboard players set #confirmed dl.gate 1
scoreboard players set #pending dl.gate 0

# Cancel the 30-second timeout
schedule clear datalib:runtime/load/loader/gate/timeout

# Announce execution via tellraw — no marker entity needed.
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Dangerous command CONFIRMED.","color":"green","bold":true},{"text":" Executing...","color":"gray"}]

# --- DISPATCH ---
# Each executor reads its own fields from datalib:engine pending_gate via datalib.
# The 'with storage' pattern passes pending_gate fields as $(macro) parameters.

# ban: requires {type:"ban", player:"...", reason:"..."}
execute if data storage datalib:engine pending_gate{type:"ban"} run function datalib:runtime/load/loader/gate/exec/ban with storage datalib:engine pending_gate

# ban_ip: requires {type:"ban_ip", player:"...", reason:"..."}
execute if data storage datalib:engine pending_gate{type:"ban_ip"} run function datalib:runtime/load/loader/gate/exec/ban_ip with storage datalib:engine pending_gate

# kick: requires {type:"kick", player:"...", reason:"..."}
execute if data storage datalib:engine pending_gate{type:"kick"} run function datalib:runtime/load/loader/gate/exec/kick with storage datalib:engine pending_gate

# disable: requires {type:"disable"} (no extra fields)
execute if data storage datalib:engine pending_gate{type:"disable"} run function datalib:runtime/load/loader/gate/exec/disable

# --- CLEANUP ---
data remove storage datalib:engine pending_gate
scoreboard players reset #pending dl.gate
scoreboard players reset #confirmed dl.gate
scoreboard objectives remove dl.gate
