# datalib:core/queue/clear
# Discards all pending work_queue items immediately.
# No macro input required.
#
# Usage:
#   function datalib:core/queue/clear

data modify storage datalib:engine work_queue set value []
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"queue/clear ","color":"aqua"},{"text":"→ work_queue emptied","color":"#555555"}]
