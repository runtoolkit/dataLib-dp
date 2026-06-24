tellraw @a ["",{"text":"❌ ","color":"red"},{"text":"[DL] ","color":"aqua","bold":true},{"text":"Version conflict! ","color":"red","bold":true},{"text":"Expected ","color":"gray"},{"text":"v6.0.0","color":"yellow","bold":true},{"text":" — stored scores do not match.","color":"gray"}]
tellraw @a ["",{"text":" ↳ ","color":"#555555"},{"text":"Run ","color":"gray"},{"text":"/reload","color":"white","underlined":true},{"text":" to reinitialize dataLib.","color":"gray"}]

tellraw @a[tag=datalib.debug] ["",{"text":"[DL/DEBUG] ","color":"aqua"},{"text":"dl.pre_version → ","color":"#555555"},{"text":"major=","color":"gray"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"yellow"},{"text":" minor=","color":"gray"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"yellow"},{"text":" patch=","color":"gray"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"yellow"},{"text":" pre=","color":"gray"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"yellow"},{"text":" (expected: 6 0 0 pre=0)","color":"red"}]

data modify storage datalib:engine _log_add_tmp.message set value "❌ Version mismatch — expected v6.0.0. Load aborted."
function datalib:systems/log/warn with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp.message
