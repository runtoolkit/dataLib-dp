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
# TO RETRY: run /reload  OR  click the button below / /function dl_load:main
# (calling dl_load:main directly re-runs stage0 without a full /reload)

# Guard: nothing pending
execute unless score #pending dl.load matches 1 run return 0

# Close the gate window
scoreboard players set #cancelled dl.load 1
scoreboard players set #pending dl.load 0
scoreboard players set #confirmed dl.load 0

# If admin called /no explicitly, cancel the still-pending timeout
schedule clear dl_load:timeout

# Announce cancellation via tellraw — no marker entity needed.
tellraw @a ["",{"text":"[DL GATE] ========================================","color":"#555555"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Load CANCELLED.","color":"red","bold":true},{"text":" datalib:engine storage was NOT modified.","color":"gray"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Engine is NOT running.","color":"gray"}]
tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"To retry: ","color":"gray"},{"text":"/reload","color":"white","underlined":true,"click_event":{"action":"run_command","command":"/reload"}},{"text":"  or  ","color":"gray"},{"text":"[Retry Load]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:main"}}]
tellraw @a ["",{"text":"[DL GATE] ========================================","color":"#555555"}]

# Tear down gate objective
scoreboard players reset #pending dl.load
scoreboard players reset #cancelled dl.load
scoreboard players reset #confirmed dl.load
scoreboard objectives remove dl.load
