# dl_load:main — load entry (no confirmation gate)
# Only soft-guard: if already loaded, optional reload data-loss warning then continue only via force path.

function datalib:config

# Archive banner (score-controlled)
execute if score #runtoolkit.archivedpacks.datalib datalib.meta matches 1 run tellraw @s {"text":"[dataLib] This pack is marked archived (#runtoolkit.archivedpacks.datalib=1).","color":"red"}

# Already loaded → data-loss prevention notice (NOT a hard gate; does not block)
execute if data storage datalib:engine global{loaded:1b} if data storage datalib:engine config{reload_warn:1b} run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Reload: engine already loaded. Live storage kept. To force full re-init: ","color":"yellow"},{"text":"/function dl_load:load/force","color":"aqua","underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:load/force"}}]

execute if data storage datalib:engine global{loaded:1b} run return 0

schedule function dl_load:load/all 31s