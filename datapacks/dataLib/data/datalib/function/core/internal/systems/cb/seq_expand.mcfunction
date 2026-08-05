# datalib:systems/cb/internal/seq_expand
# Converts cb.cmds list + interval into individual cb_queue entries.
# Each entry gets ticks_left = (index + 1) * interval.

# Init sequence state
data modify storage datalib:engine _cb_seq set from storage datalib:input cb
execute store result score #cb_seq_idx dl.tmp run data get storage datalib:engine _cb_seq.interval
scoreboard players set #cb_seq_step dl.tmp 0

execute if data storage datalib:engine _cb_seq.cmds[0] run function datalib:core/internal/systems/cb/seq_expand_loop
data remove storage datalib:engine _cb_seq
