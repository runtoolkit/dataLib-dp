# dl_load:load/fork
# Fork confirmation gate — called when fork_verified is not set.
# Player is prompted to confirm with /yes or /no.
#
# BUGFIX: previously this function had a stale-state guard
# ("drop silently if already open") that checked #pending dl.fork_gate
# matches 1 and returned 0. If a prior session left #pending=1 (e.g.
# the gate was opened but the server was restarted before confirmation),
# the gate would be permanently locked — fork_yes/fork_no would silently
# no-op, load/all would never proceed past the fork check, and the
# 30-second auto-cancel schedule would never be re-armed.
# Fixed by resetting state on every call, matching the pattern used by
# load/confirm.mcfunction (which correctly resets every time).
#
# CONFIRM:  /function dl_load:load/fork_yes
# CANCEL:   /function dl_load:load/fork_no

scoreboard objectives add dl.fork_gate dummy

# Reset any stale state from a previous incomplete gate cycle
scoreboard players set #pending dl.fork_gate 0
scoreboard players set #confirmed dl.fork_gate 0

# Open the gate window
scoreboard players set #pending dl.fork_gate 1

summon minecraft:marker ~ ~ ~ {Tags:["datalib.fork_gate"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] This copy is not marked as a fork.
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] Do you want to continue?
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] YES:    /function dl_load:load/fork_yes
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] NO:     /function dl_load:load/fork_no
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] Auto-cancel fires in 30 seconds.
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run kill @s

schedule function dl_load:load/fork_no 30s replace
