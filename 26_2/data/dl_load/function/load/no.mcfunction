# dl_load:load/no
# Admin cancelled (or timeout fired) — DL load is ABORTED.
#
# datalib:engine storage is NOT touched at any point.
# The engine remains uninitialized and fully inert.
#
# IDEMPOTENT — safe to call multiple times.
# The #pending guard ensures this is a no-op if no gate is open.
#
# ALSO CALLED BY: dl_load:timeout (auto-cancel after 5 minutes)
#
# TO RETRY: run /reload  OR  /function dl_load:_
# (calling dl_load:_ directly re-runs stage0 without a full /reload)

# Guard: nothing pending
execute unless score #pending dl.load matches 1 run return 0

# Close the gate window
scoreboard players set #cancelled dl.load 1
scoreboard players set #pending dl.load 0
scoreboard players set #confirmed dl.load 0

# If admin called /no explicitly, cancel the still-pending timeout
schedule clear dl_load:timeout

# Announce cancellation via marker (works with zero players online)
summon minecraft:marker ~ ~ ~ {Tags:["datalib.gate_no"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.gate_no,limit=1] run say [DL GATE] ========================================
execute as @e[type=minecraft:marker,tag=datalib.gate_no,limit=1] run say [DL GATE] Load CANCELLED. datalib:engine storage was NOT modified.
execute as @e[type=minecraft:marker,tag=datalib.gate_no,limit=1] run say [DL GATE] Engine is NOT running.
execute as @e[type=minecraft:marker,tag=datalib.gate_no,limit=1] run say [DL GATE] To retry: /reload  or  /function dl_load:_
execute as @e[type=minecraft:marker,tag=datalib.gate_no,limit=1] run say [DL GATE] ========================================
execute as @e[type=minecraft:marker,tag=datalib.gate_no,limit=1] run kill @s

# Tear down gate objective
scoreboard players reset #pending dl.load
scoreboard players reset #cancelled dl.load
scoreboard players reset #confirmed dl.load
scoreboard objectives remove dl.load
