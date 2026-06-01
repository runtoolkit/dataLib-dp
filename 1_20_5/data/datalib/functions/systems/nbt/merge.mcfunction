# ─────────────────────────────────────────────────────────────────
# datalib:systems/nbt/merge
# Merges a compound from src_storage:src_path into dst_storage:dst_path.
# Equivalent to: data modify <dst> merge from <src>
# Existing keys in dst are overwritten by src values; missing keys added.
#
# INPUT (storage datalib:input):
# src_storage → source storage namespace (e.g. "datalib:engine")
# src_path → source compound path
# dst_storage → destination storage namespace
# dst_path → destination compound path
#
# EXAMPLE:
# data modify storage datalib:input src_storage set value "datalib:engine"
# data modify storage datalib:input src_path set value "players.Steve"
# data modify storage datalib:input dst_storage set value "mypack:data"
# data modify storage datalib:input dst_path set value "backup.Steve"
# function datalib:systems/nbt/merge
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/nbt/merge_exec with storage datalib:engine {}
