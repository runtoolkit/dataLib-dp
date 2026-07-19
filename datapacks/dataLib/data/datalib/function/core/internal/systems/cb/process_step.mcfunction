# datalib:systems/cb/internal/process_step
# Pops first entry from _cb_work.
# ticks_left == 1 → fire now.
# ticks_left > 1  → decrement and return to cb_queue.

# Pop first entry
data modify storage datalib:engine _cb_entry set from storage datalib:engine _cb_work[0]
data remove storage datalib:engine _cb_work[0]

# Decrement ticks_left
execute store result score #cb_tl dl.tmp run data get storage datalib:engine _cb_entry.ticks_left
scoreboard players remove #cb_tl dl.tmp 1

execute if score #cb_tl dl.tmp matches ..0 run function datalib:core/internal/systems/cb/fire_entry

execute unless score #cb_tl dl.tmp matches ..0 run execute store result storage datalib:engine _cb_entry.ticks_left int 1 run scoreboard players get #cb_tl dl.tmp
execute unless score #cb_tl dl.tmp matches ..0 run data modify storage datalib:engine cb_queue append from storage datalib:engine _cb_entry

data remove storage datalib:engine _cb_entry

# Recurse if more entries remain
execute if data storage datalib:engine _cb_work[0] run function datalib:core/internal/systems/cb/process_step
