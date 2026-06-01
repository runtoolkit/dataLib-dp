scoreboard players add $pq_depth dl.tmp 1
execute if score $pq_depth dl.tmp matches 257.. run return 0

execute unless data storage datalib:engine queue[0] run return 0

execute store result score $qdel dl.tmp run data get storage datalib:engine queue[0].delay

scoreboard players remove $qdel dl.tmp 1
execute store result storage datalib:engine queue[0].delay int 1 run scoreboard players get $qdel dl.tmp

execute if score $qdel dl.tmp matches ..0 run function datalib:core/internal/lib/queue_fire
execute if score $qdel dl.tmp matches ..0 run function datalib:core/lib/process_queue
