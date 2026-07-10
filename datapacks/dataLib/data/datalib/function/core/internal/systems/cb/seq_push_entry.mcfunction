# datalib:systems/cb/internal/seq_push_entry
# Pushes current sequence step as a cb_queue entry.
# Reads: _cb_seq_cmd (string), _cb_delay (score), _cb_seq.{x,y,z}

# Build entry storage
data modify storage datalib:engine _cb_seq_entry set from storage datalib:engine _cb_seq
data remove storage datalib:engine _cb_seq_entry.cmds
data remove storage datalib:engine _cb_seq_entry.interval
data modify storage datalib:engine _cb_seq_entry.cmd set from storage datalib:engine _cb_seq_cmd
execute store result storage datalib:engine _cb_seq_entry.ticks_left int 1 run scoreboard players get #cb_delay dl.tmp

data modify storage datalib:engine cb_queue append from storage datalib:engine _cb_seq_entry
data remove storage datalib:engine _cb_seq_entry
data remove storage datalib:engine _cb_seq_cmd
