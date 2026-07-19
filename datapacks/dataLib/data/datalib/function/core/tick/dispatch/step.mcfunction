# DL Tick — Dispatch Step [MACRO]
# Recursive iterator over tick.channels[].
# Terminates automatically when index exceeds array length.
# Input: $(i) — current channel array index

# Termination: channel[i] absent → stop
$execute unless data storage datalib:engine tick.channels[$(i)] run return 0

# Process this channel
$function datalib:core/tick/dispatch/channel {i:$(i)}

# Advance: $(i)+1 → write back → recurse
$scoreboard players set #ch_next datalib.tick $(i)
scoreboard players add #ch_next datalib.tick 1
execute store result storage datalib:tick_work i int 1 run scoreboard players get #ch_next datalib.tick
function datalib:core/tick/dispatch/step with storage datalib:tick_work