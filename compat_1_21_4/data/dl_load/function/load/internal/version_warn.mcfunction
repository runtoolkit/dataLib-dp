tellraw @a ["",{"text":"❌ ","color":"red"},{"text":"[DL] ","color":"aqua","bold":true},{"text":"Version conflict! ","color":"red","bold":true},{"text":"Expected ","color":"gray"},{"text":"v5.1.2","color":"yellow","bold":true},{"text":" — stored scores do not match.","color":"gray"}]
tellraw @a ["",{"text":" ↳ ","color":"#555555"},{"text":"Run ","color":"gray"},{"text":"/reload","color":"white","underlined":true},{"text":" to reinitialize dataLib.","color":"gray"}]

tellraw @a[tag=datalib.debug] ["",{"text":"[DL/DEBUG] ","color":"aqua"},{"text":"dl.pre_version → ","color":"#555555"},{"text":"major=","color":"gray"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"yellow"},{"text":" minor=","color":"gray"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"yellow"},{"text":" patch=","color":"gray"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"yellow"},{"text":" pre=","color":"gray"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"yellow"},{"text":" (expected: 4 0 2 pre=0)","color":"red"}]

data modify storage datalib:input message set value "❌ Version mismatch — expected v5.1.2. Load aborted."
function datalib:systems/log/warn with storage datalib:input {}
data remove storage datalib:input message