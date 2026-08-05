# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/run
# Execute queued commands
# ─────────────────────────────────────────────────────────────────

# Reset statistics
execute if data storage datalib:engine _mcmd_options{profile:1b} run data modify storage datalib:engine _mcmd_stats set value {total:0,success:0,failed:0,start_time:0}
execute if data storage datalib:engine _mcmd_options{profile:1b} run execute store result storage datalib:engine _mcmd_stats.start_time int 1 run time query gametime

# Start recursive stepping
function datalib:core/internal/api/cmd/other/multi_cmd/step

# Cleanup
function datalib:core/internal/api/cmd/other/multi_cmd/cleanup

# Show statistics
execute if data storage datalib:engine _mcmd_options{profile:1b} run function datalib:core/internal/api/cmd/other/multi_cmd/show_stats

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/run ","color":"aqua"},{"text":"✔ batch done","color":"green"}]
