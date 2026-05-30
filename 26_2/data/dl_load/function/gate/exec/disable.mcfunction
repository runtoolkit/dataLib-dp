# dl_load:gate/exec/disable
# Executor for confirmed engine disable.
# Called by dl_load:gate/yes when pending_gate{type:"disable"}.
#
# Runs the full cleanup pipeline then announces shutdown via marker.
# No macro parameters needed.

function dl_load:load/internal/cleanup

summon minecraft:marker ~ ~ ~ {Tags:["datalib.gate_disable"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.gate_disable,limit=1] run say [DL] Engine DISABLED. All scoreboards and storage removed.
execute as @e[type=minecraft:marker,tag=datalib.gate_disable,limit=1] run say [DL] To reinitialize: /reload  or  /function dl_load:_
execute as @e[type=minecraft:marker,tag=datalib.gate_disable,limit=1] run kill @s
