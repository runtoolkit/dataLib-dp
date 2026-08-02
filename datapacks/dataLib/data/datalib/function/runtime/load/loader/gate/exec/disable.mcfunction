# datalib:runtime/load/loader/gate/exec/disable
# Executor for confirmed engine disable.
# Called by datalib:runtime/load/loader/gate/yes when pending_gate{type:"disable"}.
#
# Runs the full cleanup pipeline then announces shutdown via tellraw.
# No macro parameters needed.

function datalib:runtime/load/loader/core/internal/load/cleanup

tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Engine DISABLED.","color":"red","bold":true},{"text":" All scoreboards and storage removed.","color":"gray"}]
tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"To reinitialize: ","color":"gray"},{"text":"/reload","color":"white","underlined":true,"click_event":{"action":"run_command","command":"/reload"}},{"text":"  or  ","color":"gray"},{"text":"[Reinitialize]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function datalib:runtime/load/loader/main"}}]
