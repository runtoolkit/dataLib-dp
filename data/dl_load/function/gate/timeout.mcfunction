# dl_load:gate/timeout
# Fires 30 seconds after dl_load:gate/request if no admin response.
#
# Delegates to dl_load:gate/no which is idempotent — if the gate was
# already closed by an explicit /yes or /no, the #pending guard in
# gate/no returns 0 and nothing happens.

summon minecraft:marker ~ ~ ~ {Tags:["datalib.gtimeout"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.gtimeout,limit=1] run say [DL GATE] Dangerous command timeout (30s) — auto-cancelling.
execute as @e[type=minecraft:marker,tag=datalib.gtimeout,limit=1] run kill @s

execute if score #pending dl.gate matches 1 run function dl_load:gate/no