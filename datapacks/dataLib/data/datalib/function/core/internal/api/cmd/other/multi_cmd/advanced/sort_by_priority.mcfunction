# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/advanced/internal/sort_by_priority
# Sorts _mcmd_queue by priority field (ascending).
# Items with no priority field default to 0 (middle bucket).
# Buckets: negative | zero/unset | positive
# Uses sort_scan_loop (classify) + sort_append_loop (merge).
# ─────────────────────────────────────────────────────────────────

# Move queue to sort_buf; initialize buckets
data modify storage datalib:engine _sort_buf set from storage datalib:engine _mcmd_queue
data modify storage datalib:engine _sort_neg set value []
data modify storage datalib:engine _sort_zero set value []
data modify storage datalib:engine _sort_pos set value []

# Classify each item into the correct bucket
function datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_scan_loop

# Rebuild queue: neg → zero → pos
data modify storage datalib:engine _mcmd_queue set value []

data modify storage datalib:engine _sort_tmp set from storage datalib:engine _sort_neg
function datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop

data modify storage datalib:engine _sort_tmp set from storage datalib:engine _sort_zero
function datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop

data modify storage datalib:engine _sort_tmp set from storage datalib:engine _sort_pos
function datalib:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop

# Cleanup
data remove storage datalib:engine _sort_buf
data remove storage datalib:engine _sort_neg
data remove storage datalib:engine _sort_zero
data remove storage datalib:engine _sort_pos
data remove storage datalib:engine _sort_tmp
data remove storage datalib:engine _sort_cur

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/sort ","color":"aqua"},{"text":"✔ sorted by priority","color":"green"}]