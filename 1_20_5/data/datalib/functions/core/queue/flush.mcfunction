# datalib:core/queue/flush
# Processes ALL remaining work_queue items in a single tick.
# WARNING: large queues will cause a lag spike. Use only when you know
#          the queue is small (< ~50 items) or in a controlled context.
# No macro input required.
#
# Usage:
#   function datalib:core/queue/flush

execute if data storage datalib:engine work_queue[0] run function datalib:core/internal/queue/flush_loop
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"queue/flush ","color":"aqua"},{"text":"→ done","color":"green"}]
