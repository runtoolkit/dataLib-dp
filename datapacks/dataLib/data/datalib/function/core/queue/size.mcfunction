# datalib:core/queue/size
# Writes the current work_queue item count to datalib:output queue.size.
# No macro input required.
#
# Output (datalib:output queue):
#   size — int  number of pending items
#
# Usage:
#   function datalib:core/queue/size
#   data get storage datalib:output queue.size

execute store result storage datalib:output queue.size int 1 run data get storage datalib:engine work_queue
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"queue/size ","color":"aqua"},{"text":"→ ","color":"#555555"},{"storage":"datalib:output","nbt":"queue.size","color":"yellow"}]
