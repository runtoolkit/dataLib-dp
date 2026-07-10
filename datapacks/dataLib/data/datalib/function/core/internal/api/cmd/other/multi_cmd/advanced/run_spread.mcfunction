# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/advanced/internal/run_spread
# Spreads _mcmd_queue execution: one item per tick.
# Schedules run_spread_tick which self-reschedules until queue is drained.
# Supports full item format (conditions, hooks, cmd, func).
# ─────────────────────────────────────────────────────────────────

execute if data storage datalib:engine _mcmd_queue[0] run schedule function datalib:core/internal/api/cmd/other/multi_cmd/advanced/run_spread_tick 1t append

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/run_spread ","color":"aqua"},{"text":"↷ spread scheduled","color":"gray"}]