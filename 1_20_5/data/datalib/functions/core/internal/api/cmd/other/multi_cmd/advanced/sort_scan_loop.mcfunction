# ─────────────────────────────────────────────────────────────────
# datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_scan_loop
# Recursive: dequeue one item from _sort_buf and classify it.
# ─────────────────────────────────────────────────────────────────

execute unless data storage datalib:engine _sort_buf[0] run return 0

data modify storage datalib:engine _sort_cur set from storage datalib:engine _sort_buf[0]
data remove storage datalib:engine _sort_buf[0]

# Read priority into scoreboard — returns 0 if field absent (desired default)
execute store result score $sort_pri dl.tmp run data get storage datalib:engine _sort_cur.priority

execute if score $sort_pri dl.tmp matches ..-1 run data modify storage datalib:engine _sort_neg append from storage datalib:engine _sort_cur
execute if score $sort_pri dl.tmp matches 0 run data modify storage datalib:engine _sort_zero append from storage datalib:engine _sort_cur
execute if score $sort_pri dl.tmp matches 1.. run data modify storage datalib:engine _sort_pos append from storage datalib:engine _sort_cur

scoreboard players reset $sort_pri dl.tmp

function datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_scan_loop
