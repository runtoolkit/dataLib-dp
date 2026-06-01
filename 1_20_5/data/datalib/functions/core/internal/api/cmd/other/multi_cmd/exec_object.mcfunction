# ─────────────────────────────────────────────────────────────────
# datalib:core/internal/api/cmd/other/multi_cmd/exec_object
# Execute advanced object command
# _mcmd_current format: {cmd:"...", condition:{}, priority:0}
# ─────────────────────────────────────────────────────────────────

# Check condition (if present)
execute if data storage datalib:engine _mcmd_current.condition run function datalib:core/internal/api/cmd/other/multi_cmd/check_condition
execute if data storage datalib:engine _mcmd_current.condition if score $mcmd_cond_result dl.tmp matches 0 run return 0

# Run pre-hook (if present)
execute if data storage datalib:engine _mcmd_current.pre_hook run function datalib:core/internal/api/cmd/other/multi_cmd/run_pre_hook

# Start profiling (if present)
execute if data storage datalib:engine _mcmd_options{profile:1b} run execute store result score $mcmd_exec_start dl.tmp run time query gametime

# Execute command
execute if data storage datalib:engine _mcmd_current.cmd run function datalib:core/internal/api/cmd/other/multi_cmd/exec_macro with storage datalib:engine _mcmd_current
execute if data storage datalib:engine _mcmd_current.func run function datalib:core/internal/api/cmd/other/multi_cmd/exec_func_macro with storage datalib:engine _mcmd_current

# End profiling (if present)
execute if data storage datalib:engine _mcmd_options{profile:1b} run function datalib:core/internal/api/cmd/other/multi_cmd/record_exec_time

# Run post-hook (if present)
execute if data storage datalib:engine _mcmd_current.post_hook run function datalib:core/internal/api/cmd/other/multi_cmd/run_post_hook

# Track stats
execute if data storage datalib:engine _mcmd_options{profile:1b} run scoreboard players add $mcmd_success dl.tmp 1
