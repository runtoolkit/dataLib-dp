# dl_load:core/internal/load/version_warn [1.20.5 overlay]
# Called when dl.pre_version scores do not match expected (6.0.0).
# Fires error tellraw. Load aborted by validate.mcfunction.

tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Version conflict! ","color":"red","bold":true},{"text":"Expected ","color":"#555555"},{"text":"v6.0.0","color":"aqua","bold":true},{"text":" — stored scores do not match.","color":"#555555"}]
tellraw @a ["",{"text":" ","color":"#555555"},{"text":"→ Run ","color":"gray"},{"text":"/reload","color":"aqua","underlined":true,"hoverEvent":{"action":"show_text","value":"Reload DataLib"}},{"text":" to reinitialize dataLib.","color":"gray"}]

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"DEBUG ","color":"aqua"},{"text":"dl.pre_version scores → ","color":"#555555"},{"text":"major=","color":"gray"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"yellow"},{"text":" minor=","color":"gray"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"yellow"},{"text":" patch=","color":"gray"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"yellow"},{"text":" pre=","color":"gray"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"yellow"},{"text":" (expected: 6 0 0 pre=0)","color":"red"}]

data modify storage datalib:engine _log_add_tmp.message set value "✘ Version mismatch — expected v6.0.0. Load aborted."
function datalib:systems/log/warn with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp.message