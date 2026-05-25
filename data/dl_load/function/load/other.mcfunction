forceload add 0 0
function datalib:_rt_origin

data modify storage datalib:input func set value "datalib:core/lib/sync_tick"
data modify storage datalib:input interval set value 20
data modify storage datalib:input key set value "sync_tick"
function datalib:core/lib/schedule with storage datalib:input {}
data remove storage datalib:input func
data remove storage datalib:input interval
data remove storage datalib:input key

scoreboard players enable @a[tag=datalib.admin] dl_menu
scoreboard players enable @a[tag=datalib.admin] dl_run
scoreboard players enable @a[tag=datalib.admin] dl_action

# Initialize tick channel config on first world load
function datalib:core/tick/init_channels

# Assign pid for any players already online at load time
# (on_player_join won't fire for them after a /reload)
execute as @a run function datalib:player/internal/init_online