# ============================================================
# datalib:systems/uuid/internal/match_check [MACRO FUNCTION]
# Dynamically compares the current UUID string with _match_target
#
# Call: function datalib:modules/uuid/internal/match_check with storage datalib:input
# $(value) = current UUID string written by from_entity
# ============================================================
$execute if data storage datalib:uuid {_match_target:"$(value)"} run function datalib:modules/uuid/internal/match_fire with storage datalib:input
