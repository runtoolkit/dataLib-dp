# ─────────────────────────────────────────────────────────────────
# datalib:systems/nbt/copy
# Copies a path between two storages or within the same storage.
#
# INPUT (storage datalib:input):
# src_storage → source storage namespace (e.g. "datalib:engine")
# src_path → source NBT path (e.g. "players.Steve")
# dst_storage → destination storage namespace
# dst_path → destination NBT path
#
# EXAMPLE:
# data modify storage datalib:input src_storage set value "datalib:engine"
# data modify storage datalib:input src_path set value "players.Steve"
# data modify storage datalib:input dst_storage set value "mypack:data"
# data modify storage datalib:input dst_path set value "backup.Steve"
# function datalib:systems/nbt/copy
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/nbt/copy_exec with storage datalib:input {}
