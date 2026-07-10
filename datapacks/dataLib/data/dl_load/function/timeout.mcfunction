# dl_load:timeout
# Fires 5 minutes after dl_load:load/confirm if no admin response.
#
# Uses the marker say pattern so the log message appears even when
# zero players are online (unlike tellraw @a).
#
# Delegates to dl_load:load/no which is idempotent — if the admin
# already ran /yes or /no, the #pending guard in load/no returns 0
# and nothing happens.

summon minecraft:marker ~ ~ ~ {Tags:["datalib.timeout"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.timeout,limit=1] run say [DL GATE] Timeout — no admin response in 5 minutes. Auto-cancelling.
execute as @e[type=minecraft:marker,tag=datalib.timeout,limit=1] run kill @s

# Delegate to load/no (idempotent — no-op if gate already closed)
execute if score #pending dl.load matches 1 run function dl_load:load/no