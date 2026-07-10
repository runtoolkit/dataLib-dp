# datalib:api/cb/list
# ─────────────────────────────────────────────────────────────────
# Prints pending queue entries to the executor.
# Shows each queued command and its remaining ticks.
# ─────────────────────────────────────────────────────────────────

execute unless function datalib:core/security/cmd_gate run return 0

execute store result score #cb_queue_size dl.tmp run data get storage datalib:engine cb_queue
execute if score #cb_queue_size dl.tmp matches 0 run tellraw @s [{"text":"[DL/cb] ","color":"#00AAAA","bold":true},{"text":"Queue is empty","color":"gray"}]
execute unless score #cb_queue_size dl.tmp matches 0 run tellraw @s [{"text":"[DL/cb] Queue (","color":"#00AAAA","bold":true},{"score":{"name":"#cb_queue_size","objective":"dl.tmp"}},{"text":" entries):","color":"#00AAAA","bold":true}]
execute unless score #cb_queue_size dl.tmp matches 0 run tellraw @s {"nbt":"cb_queue","storage":"datalib:engine","interpret":false}
