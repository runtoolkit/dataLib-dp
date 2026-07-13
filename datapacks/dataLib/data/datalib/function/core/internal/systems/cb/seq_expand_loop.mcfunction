# datalib:systems/cb/internal/seq_expand_loop
# Pops first cmd from _cb_seq.cmds, computes its delay, pushes to queue.

# Increment step counter and compute cumulative delay
scoreboard players add #cb_seq_step dl.tmp 1
execute store result score #cb_delay dl.tmp run scoreboard players get #cb_seq_step dl.tmp
scoreboard players operation #cb_delay dl.tmp *= #cb_seq_idx dl.tmp

# Pop cmd from list into scratch
data modify storage datalib:engine _cb_seq_cmd set from storage datalib:engine _cb_seq.cmds[0]
data remove storage datalib:engine _cb_seq.cmds[0]

# Write queue entry
function datalib:core/internal/systems/cb/seq_push_entry

# Continue if more cmds remain
execute if data storage datalib:engine _cb_seq.cmds[0] run function datalib:core/internal/systems/cb/seq_expand_loop
