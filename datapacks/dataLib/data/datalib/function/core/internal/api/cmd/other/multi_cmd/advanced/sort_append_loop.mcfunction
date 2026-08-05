# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/advanced/internal/sort_append_loop
# Recursive: drain _sort_tmp into _mcmd_queue one item at a time.
# ─────────────────────────────────────────────────────────────────

execute unless data storage datalib:engine _sort_tmp[0] run return 0

data modify storage datalib:engine _mcmd_queue append from storage datalib:engine _sort_tmp[0]
data remove storage datalib:engine _sort_tmp[0]

function datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop
