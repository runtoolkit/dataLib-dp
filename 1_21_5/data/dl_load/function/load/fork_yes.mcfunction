# dl_load:load/fork_yes
# Fork confirmation gate — /yes response.
# Runs safe_load and sets fork_verified to 0b.
#
# USAGE:
#   /function dl_load:load/fork_yes

# Guard: gate must be open
execute unless score #pending dl.fork_gate matches 1 run return 0

# Guard: already confirmed
execute if score #confirmed dl.fork_gate matches 1 run return 0

scoreboard players set #confirmed dl.fork_gate 1
scoreboard players set #pending dl.fork_gate 0

schedule clear dl_load:load/fork_no

summon minecraft:marker ~ ~ ~ {Tags:["datalib.fork_yes"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.fork_yes,limit=1] run say [DL FORK GATE] Confirmed — running safe_load.
execute as @e[type=minecraft:marker,tag=datalib.fork_yes,limit=1] run kill @s

# fork_verified = 0b (fork, confirmed by operator)
data modify storage datalib:engine global.fork_verified set value 0b

function dl_load:safe_load/yes
