# dl_load:gate/timeout
# Scheduled 30s after gate/request. If the gate is still pending (nobody
# confirmed or cancelled it), auto-cancel it. If gate/yes or gate/no
# already resolved it, this call is a no-op (the schedule was cleared).

execute unless data storage datalib:engine pending_gate run return 0

tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Timed out: ","color":"gray"},{"nbt":"pending_gate.label","storage":"datalib:engine","color":"white"},{"text":" (30s, no response)","color":"gray"}]

data remove storage datalib:engine pending_gate
