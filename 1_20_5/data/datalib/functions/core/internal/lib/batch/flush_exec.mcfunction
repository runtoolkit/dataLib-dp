# datalib:core/internal/lib/batch/flush_exec [MACRO]
# INPUT: $(id)
# For each item, delay = floor(idx * spread_over / total) is computed.
# Item'lar tek tek process_queue'ya eklenir — slice storage gerekmez.

$execute unless data storage datalib:engine batches.$(id) run return 0

# Load total and spread_over values to score
$execute store result score $bfl_total dl.tmp run data get storage datalib:engine batches.$(id).items
$execute store result score $bfl_spread dl.tmp run data get storage datalib:engine batches.$(id).spread_over
execute if score $bfl_spread dl.tmp matches ..0 run scoreboard players set $bfl_spread dl.tmp 1
execute if score $bfl_total dl.tmp matches 0 run return 0

# Iteration counter
scoreboard players set $bfl_idx dl.tmp 0

# Copy items to working storage
$data modify storage datalib:engine _bfl_items set from storage datalib:engine batches.$(id).items
$data modify storage datalib:engine _bfl_id set value "$(id)"

function datalib:core/internal/lib/batch/flush_loop

data remove storage datalib:engine _bfl_items
data remove storage datalib:engine _bfl_id
scoreboard players reset $bfl_idx dl.tmp
scoreboard players reset $bfl_total dl.tmp
scoreboard players reset $bfl_spread dl.tmp

$data remove storage datalib:engine batches.$(id)

$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/batch/flush ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" — queued","color":"green"}]}
