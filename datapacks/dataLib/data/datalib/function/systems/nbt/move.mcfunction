# ─────────────────────────────────────────────────────────────────
# datalib:systems/nbt/move
# Moves a path within the same storage (copy + delete).
#
# INPUT (storage datalib:input):
# storage → storage namespace
# from_path → source path
# to_path → destination path
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/nbt/move_exec with storage datalib:input {}
