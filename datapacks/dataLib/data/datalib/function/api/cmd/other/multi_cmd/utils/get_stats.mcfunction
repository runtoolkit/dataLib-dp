# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/utils/get_stats
# Mevcut istatistikleri datalib:output'a kopyala
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output stats set from storage datalib:engine _mcmd_stats
