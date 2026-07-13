# DL Tick — Channel Dispatcher
# Increments the internal tick counter then iterates all channels.

scoreboard players add #tick_ctr datalib.tick 1
data modify storage datalib:tick_work i set value 0
function datalib:core/tick/dispatch/step with storage datalib:tick_work