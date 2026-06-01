forceload add 0 0

data modify storage datalib:input func set value "datalib:core/lib/sync_tick"
data modify storage datalib:input interval set value 20
data modify storage datalib:input key set value "sync_tick"
function datalib:core/lib/schedule with storage datalib:engine {}
data remove storage datalib:input func
data remove storage datalib:input interval
data remove storage datalib:input key

scoreboard players enable @a[tag=datalib.admin] dl_menu
scoreboard players enable @a[tag=datalib.admin] datalib_run
scoreboard players enable @a[tag=datalib.admin] datalib_action

# Initialize tick channel config on first world load
function datalib:core/tick/init_channels
