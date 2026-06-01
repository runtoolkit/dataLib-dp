# ─────────────────────────────────────────────────────────────────
# datalib:systems/nbt/exists
# Checks whether a specific path exists in storage.
#
# INPUT (storage datalib:input):
# storage → storage namespace
# path → kontrol edilecek path
#
# OUTPUT: datalib:output result → 1b (exists) or 0b (does not exist)
# ─────────────────────────────────────────────────────────────────

function datalib:systems/nbt/internal/exists_exec with storage datalib:input {}
