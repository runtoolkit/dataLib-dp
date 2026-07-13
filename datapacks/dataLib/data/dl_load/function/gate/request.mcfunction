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
#   2. Broadcasts confirmation instructions via marker say
#   3. Schedules a 30-second auto-cancel
#
# CONFIRMING:  /function dl_load:gate/yes
# CANCELLING:  /function dl_load:gate/no
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

# Broadcast via marker (server-startup safe, no player context needed)
summon minecraft:marker ~ ~ ~ {Tags:["datalib.gate_req"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.gate_req,limit=1] run say [DL GATE] Dangerous command pending — awaiting confirmation.
execute as @e[type=minecraft:marker,tag=datalib.gate_req,limit=1] run say [DL GATE] CONFIRM:  /function dl_load:gate/yes
execute as @e[type=minecraft:marker,tag=datalib.gate_req,limit=1] run say [DL GATE] CANCEL:   /function dl_load:gate/no
execute as @e[type=minecraft:marker,tag=datalib.gate_req,limit=1] run say [DL GATE] Auto-cancel fires in 30 seconds.
execute as @e[type=minecraft:marker,tag=datalib.gate_req,limit=1] run kill @s

# Schedule 30-second auto-cancel for dangerous commands
schedule function dl_load:gate/timeout 30s replace