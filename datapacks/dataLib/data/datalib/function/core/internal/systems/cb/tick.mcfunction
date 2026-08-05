# datalib:systems/cb/internal/tick
# Called each tick when cb_queue is non-empty.
# Processes all entries: decrements ticks_left, fires those that reach 0.

# Copy queue to work buffer, clear queue, rebuild after processing
data modify storage datalib:engine _cb_work set from storage datalib:engine cb_queue
data remove storage datalib:engine cb_queue
data modify storage datalib:engine cb_queue set value []

execute if data storage datalib:engine _cb_work[0] run function datalib:core/internal/systems/cb/process_step
data remove storage datalib:engine _cb_work
