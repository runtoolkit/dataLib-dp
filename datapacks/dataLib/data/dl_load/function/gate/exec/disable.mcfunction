# dl_load:gate/exec/disable
# Executor for confirmed engine disable.
# Called by dl_load:gate/yes when pending_gate{type:"disable"}.
#
# Runs the full cleanup pipeline then announces shutdown via tellraw.
# No macro parameters needed.

function dl_load:core/internal/load/cleanup

tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Engine DISABLED.","color":"red","bold":true},{"text":" All scoreboards and storage removed.","color":"gray"}]
tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"To reinitialize: ","color":"gray"},{"text":"/reload","color":"white","underlined":true,"click_event":{"action":"run_command","command":"/reload"}},{"text":"  or  ","color":"gray"},{"text":"[Reinitialize]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:main"}}]
