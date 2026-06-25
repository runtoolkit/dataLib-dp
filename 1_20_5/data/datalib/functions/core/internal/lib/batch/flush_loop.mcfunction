# datalib:core/internal/lib/batch/flush_loop
# Consumes _bfl_items. For each item:
# delay = floor($bfl_idx * $bfl_spread / $bfl_total)
# computed and added to the queue.
# func or cmd presence is checked with execute if data.

execute unless data storage datalib:engine _bfl_items[0] run return 0

# delay = floor(idx * spread / total)
scoreboard players operation $bfl_delay dl.tmp = $bfl_idx dl.tmp
scoreboard players operation $bfl_delay dl.tmp *= $bfl_spread dl.tmp
scoreboard players operation $bfl_delay dl.tmp /= $bfl_total dl.tmp

# Move item to temporary storage
data modify storage datalib:engine _bfl_cur set from storage datalib:engine _bfl_items[0]
data remove storage datalib:engine _bfl_items[0]

# Write delay to item, then queue by func/cmd
execute store result storage datalib:engine _bfl_cur.delay int 1 run scoreboard players get $bfl_delay dl.tmp

execute if data storage datalib:engine _bfl_cur.func run function datalib:core/internal/lib/batch/flush_queue_func with storage datalib:engine _bfl_cur
execute unless data storage datalib:engine _bfl_cur.func run execute if data storage datalib:engine _bfl_cur.cmd run function datalib:core/internal/lib/batch/flush_queue_cmd with storage datalib:engine _bfl_cur

data remove storage datalib:engine _bfl_cur
scoreboard players add $bfl_idx dl.tmp 1

function datalib:core/internal/lib/batch/flush_loop