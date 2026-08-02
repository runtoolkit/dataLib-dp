# datalib:systems/cb/internal/queue_push
# Macro: receives {cmd, delay, x, y, z}
# Appends an entry to datalib:engine cb_queue list.
# Each entry: {cmd, delay, x, y, z, ticks_left}
# ticks_left is decremented each tick; fires when it hits 0.

$data modify storage datalib:engine cb_queue append value {cmd:"$(cmd)",x:$(x),y:$(y),z:$(z),ticks_left:$(delay)}
