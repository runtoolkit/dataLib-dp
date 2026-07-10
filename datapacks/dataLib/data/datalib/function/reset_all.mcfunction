function datalib:core/disable/main

function datalib:systems/hook/unbind_all
function datalib:api/trigger/unbind_all
function datalib:api/wand/unregister_all
data remove storage datalib:engine interaction_binds
data remove storage datalib:engine fibers
data remove storage datalib:engine perm_triggers
data remove storage datalib:engine perm_trigger_names
data remove storage datalib:engine log_display
data remove storage datalib:engine schedules
data remove storage datalib:engine global.tick
data remove storage datalib:engine global.epoch

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Engine disabled. ","color":"red"},{"text":"Restart → ","color":"#555555"},{"text":"/reload","color":"aqua","bold":true,"underlined":true}]