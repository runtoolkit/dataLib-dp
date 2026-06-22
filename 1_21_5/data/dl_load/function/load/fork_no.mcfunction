# dl_load:load/fork_no
# Fork confirmation gate — /no response or 30s timeout.
# Runs normal load, fork_verified is not set.
#
# USAGE:
#   /function dl_load:load/fork_no

# Guard: gate must be open
execute unless score #pending dl.fork_gate matches 1 run return 0

# Guard: already confirmed
execute if score #confirmed dl.fork_gate matches 1 run return 0

scoreboard players set #pending dl.fork_gate 0

schedule clear dl_load:load/fork_no

summon minecraft:marker ~ ~ ~ {Tags:["datalib.fork_no"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.fork_no,limit=1] run say [DL FORK GATE] Cancelled — continuing with normal load.
execute as @e[type=minecraft:marker,tag=datalib.fork_no,limit=1] run kill @s

function dl_load:load/yes
