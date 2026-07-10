# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/internal/check_condition
# Check condition and write result to $mcmd_cond_result
# _mcmd_current.condition: {tag:"...", score:{...}, predicate:"..."}
# ─────────────────────────────────────────────────────────────────

# Default: condition passed
scoreboard players set $mcmd_cond_result dl.tmp 1

# Tag check
execute if data storage datalib:engine _mcmd_current.condition.tag run function datalib:core/internal/api/cmd/other/multi_cmd/cond_check_tag

# Score check
execute if data storage datalib:engine _mcmd_current.condition.score run function datalib:core/internal/api/cmd/other/multi_cmd/cond_check_score

# Predicate check
execute if data storage datalib:engine _mcmd_current.condition.predicate run function datalib:core/internal/api/cmd/other/multi_cmd/cond_check_predicate

# Entity check (selector)
execute if data storage datalib:engine _mcmd_current.condition.entity run function datalib:core/internal/api/cmd/other/multi_cmd/cond_check_entity

# Storage check
execute if data storage datalib:engine _mcmd_current.condition.storage run function datalib:core/internal/api/cmd/other/multi_cmd/cond_check_storage
