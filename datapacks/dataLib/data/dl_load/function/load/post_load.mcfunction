# Stage 4 — post_load: schedule #datalib:init after DL finishes loading
# dl_load:load/all is scheduled at t+16 (from Stage 0 in dl_load:main).
# Firing #datalib:init at t+20 gives 4 ticks of margin after dataLib is fully ready.
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Scheduling #datalib:init (t+20)...","color":"gray"}]
schedule function #datalib:init 20t replace
