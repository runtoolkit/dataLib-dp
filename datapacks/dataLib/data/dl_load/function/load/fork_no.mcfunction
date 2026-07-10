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

# BUGFIX: this was the only path through load/all.mcfunction that never
# set global.fork_verified. load/all's fork-gate check is
# "execute unless data storage datalib:engine global.fork_verified run
# return run function dl_load:load/fork" — it only treats the gate as
# resolved once the FIELD EXISTS (1b=original, 0b=confirmed fork, per
# load/all's own comment), not based on which choice was made. Since
# load/yes always reschedules load/all 1 tick later, leaving the field
# unset here meant every /no answer led straight back into load/all
# re-opening the same fork gate again — an infinite confirmation loop,
# reproduced live: fork_no fired repeatedly every few seconds without
# the operator doing anything, because load/yes -> load/all -> fork
# (field still unset) -> wait for input -> fork_no -> load/yes -> ...
# 1b marks this copy as "not a fork, operator dismissed the prompt" —
# distinct from fork_yes's 0b ("is a fork, operator confirmed it").
data modify storage datalib:engine global.fork_verified set value 1b

summon minecraft:marker ~ ~ ~ {Tags:["datalib.fork_no"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.fork_no,limit=1] run say [DL FORK GATE] Cancelled — continuing with normal load.
execute as @e[type=minecraft:marker,tag=datalib.fork_no,limit=1] run kill @s

function dl_load:load/yes
