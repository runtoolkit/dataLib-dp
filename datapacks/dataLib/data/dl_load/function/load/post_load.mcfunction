# Stage 4 — post_load: schedule #datalib:init after DL finishes loading
# dl_load:load/all is scheduled at t+16 (from Stage 0 in dl_load:_).
# Firing #datalib:init at t+20 gives 4 ticks of margin after dataLib is fully ready.
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage4"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage4,limit=1] run say Scheduling #datalib:init (t+20)...
execute as @e[type=minecraft:marker,tag=datalib.stage4,limit=1] run schedule function #datalib:init 20t replace
execute as @e[type=minecraft:marker,tag=datalib.stage4,limit=1] run kill @s
