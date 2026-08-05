function datalib:core/lib/process_queue

# CB delay queue — process pending command block executions
execute if data storage datalib:engine modules{cb:1b} run execute if data storage datalib:engine cb_queue[0] run function datalib:core/internal/systems/cb/tick
