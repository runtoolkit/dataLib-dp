# ============================================================
# datalib:core/internal/systems/uuid/match_check [MACRO FUNCTION]
# Dynamically compares the current UUID string with _match_target
#
# Call: function datalib:core/internal/systems/uuid/match_check with storage datalib:engine
# $(value) = current UUID string written by from_entity
# ============================================================
$execute if data storage datalib:uuid {_match_target:"$(value)"} run function datalib:core/internal/systems/uuid/match_fire with storage datalib:engine
