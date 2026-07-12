# dl_load:core/internal/load/version_warn
# Called when dl.pre_version scores don't match expected (6.0.1-pre1).
# Fires error sound + plain error message, load aborted.

playsound datalib:ui.error master @a ~ ~ ~ 0.7 0.8

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Version mismatch — expected ","color":"red"},{"text":"v6.0.1-pre1","color":"aqua"},{"text":". Load aborted.","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"DEBUG ","color":"aqua"},{"text":"expected: 6.0.1-pre1 · got: ","color":"#555555"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"yellow"},{"text":".","color":"#555555"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"yellow"},{"text":".","color":"#555555"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"yellow"}]

data modify storage datalib:engine _log_error_tmp set value {message:"[Load] version_warn — version mismatch, load aborted"}
function datalib:systems/log/error with storage datalib:engine _log_error_tmp
