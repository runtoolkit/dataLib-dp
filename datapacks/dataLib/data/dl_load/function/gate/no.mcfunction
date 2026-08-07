# dl_load:gate/no
# Cancels the pending gated action without running it.
# Only players with datalib.admin may call this directly (same trust
# boundary as gate/yes).

execute unless entity @s[tag=datalib.admin] run return 0
execute unless data storage datalib:engine pending_gate run return 0

schedule clear dl_load:gate/timeout

tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Cancelled: ","color":"gray"},{"nbt":"pending_gate.label","storage":"datalib:engine","color":"white"}]

data remove storage datalib:engine pending_gate
