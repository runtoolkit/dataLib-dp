# ─────────────────────────────────────────────────────────────────
# datalib:modules/nbt/api/first
# Copies the first element [0] of a list at src_path into dst_path.
# If the list is empty or path does not exist, does nothing (silent fail).
#
# INPUT (storage datalib:input):
# src_storage → source storage namespace
# src_path → list path (element [0] will be read)
# dst_storage → destination storage namespace
# dst_path → destination path to write into
#
# EXAMPLE:
# data modify storage datalib:input src_storage set value "datalib:engine"
# data modify storage datalib:input src_path set value "event_queue"
# data modify storage datalib:input dst_storage set value "datalib:output"
# data modify storage datalib:input dst_path set value "result"
# function datalib:modules/nbt/api/first
# ─────────────────────────────────────────────────────────────────

function datalib:modules/nbt/internal/first_exec with storage datalib:input {}
