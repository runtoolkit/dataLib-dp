# datalib:core/queue/push_as
# Appends a function to the work queue, tagged to execute AS a specific player.
# The player must be online when the item is processed; if offline, it is skipped.
#
# Input  (datalib:input queue):
#   fn     — function path          e.g. "mypack:process_player"
#   player — player name or UUID    e.g. "<player name>"
#
# Usage:
#   data modify storage datalib:input queue set value {fn:"mypack:process_player",player:"<player name>"}
#   function datalib:core/queue/push_as with storage datalib:input queue

$data modify storage datalib:engine work_queue append value {fn:"$(fn)",player:"$(player)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"queue/push_as ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(fn)","color":"white"},{"text":" as ","color":"#555555"},{"text":"$(player)","color":"#FFAA00"}]
