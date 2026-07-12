# dl_load:load/fork
# Fork confirmation gate — called when fork_verified is not set.
# Player is prompted to confirm with /yes or /no.
#
# USAGE:
#   /function dl_load:load/fork
#
# CONFIRM:  /function dl_load:load/fork_yes
# CANCEL:   /function dl_load:load/fork_no

scoreboard objectives add dl.fork_gate dummy

# Reset any stale state from a previous incomplete gate cycle.
# Without this, a #pending=1 left over from a prior session/reload
# (objectives add is idempotent and does NOT reset values) would
# permanently lock this gate: fork_yes/fork_no both guard on
# "#pending matches 1", and the early "drop if already open" check
# below would keep returning before ever re-arming the 30s timeout.
scoreboard players set #pending dl.fork_gate 0
scoreboard players set #confirmed dl.fork_gate 0

scoreboard players set #pending dl.fork_gate 1

summon minecraft:marker ~ ~ ~ {Tags:["datalib.fork_gate"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] This copy is not marked as a fork.
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] Do you want to continue?
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] YES:    /function dl_load:load/fork_yes
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] NO:     /function dl_load:load/fork_no
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] Auto-cancel fires in 30 seconds.
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run kill @s

schedule function dl_load:load/fork_no 30s replace
