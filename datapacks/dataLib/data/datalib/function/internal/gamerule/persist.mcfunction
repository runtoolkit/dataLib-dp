# datalib:api/gamerule/internal/persist [MACRO]
# Writes the normalized rule name + value into datalib:engine gamerules compound.
# Called exclusively by datalib:api/gamerule/set — do NOT call directly.
#
# INPUT (macro args via `with storage datalib:input {}`):
#   $(_gamerule_norm) — normalized rule name (spaces → underscores, lowercase)
#   $(value)          — value string

$data modify storage datalib:engine gamerules.$(_gamerule_norm) set value "$(value)"
