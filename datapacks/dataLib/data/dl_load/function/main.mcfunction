# dl_load:main — load entry
# Initial load runs unblocked (no confirmation gate — must not stall server
# startup). Reload data-loss is only a soft warning here; the actual
# force-reload path (dl_load:load/force) is gated when sandbox:1b —
# clicking the link below opens a confirm/cancel prompt instead of
# force-reiniting immediately. See dl_load:gate/request.

function datalib:config

# Archive banner (score-controlled)
execute if score #runtoolkit.archivedpacks.datalib datalib.meta matches 1 run tellraw @s {"text":"[dataLib] This pack is marked archived (#runtoolkit.archivedpacks.datalib=1).","color":"red"}

# Already loaded → data-loss prevention notice (NOT a hard gate; does not block)
execute if data storage datalib:engine global{loaded:1b} if data storage datalib:engine config{reload_warn:1b} run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Reload: engine already loaded. Live storage kept. To force full re-init (requires confirmation): ","color":"yellow"},{"text":"/function dl_load:load/force","color":"aqua","underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:load/force"}}]

execute if data storage datalib:engine global{loaded:1b} run return 0

schedule function dl_load:load/all 2s
