# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/internal/cleanup
# Cleanup — remove temporary storages
# ─────────────────────────────────────────────────────────────────

data remove storage datalib:engine _mcmd_queue
data remove storage datalib:engine _mcmd_current
data remove storage datalib:engine _mcmd_exec
data remove storage datalib:engine _mcmd_cond_tmp

# Sort temporaries (no-op if sort was not used)
data remove storage datalib:engine _sort_neg
data remove storage datalib:engine _sort_zero
data remove storage datalib:engine _sort_pos
data remove storage datalib:engine _sort_buf
data remove storage datalib:engine _sort_tmp
data remove storage datalib:engine _sort_cur

scoreboard players reset $mcmd_cond_result dl.tmp
scoreboard players reset $mcmd_cond_score dl.tmp
scoreboard players reset $sort_pri dl.tmp
