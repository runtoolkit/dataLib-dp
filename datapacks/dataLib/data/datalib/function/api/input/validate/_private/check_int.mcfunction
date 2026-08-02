# ======================================================================================
# datalib:api/input/validate/_private/check_int  [INTERNAL]
# ======================================================================================
#
# FAST METHOD (no per-character recursion):
#   A string is "all digits, optional leading -" iff:
#     1. stripping one leading '-' (if present) leaves a non-empty rest, AND
#     2. the sum of how many times each of '0'..'9' occurs in that rest,
#        via datalib:modules/string/api/legacy/find, equals the rest's total length.
#   If every character is one of the 10 digits, the counts must add up to
#   the full length — any non-digit character breaks the sum by definition,
#   without needing to inspect it directly.
#
# Reuses datalib:modules/string/api/legacy/find (read-only substring search) — this never
# executes the input, only counts characters via a library already
# audited for the $$(command) macro-injection fix.
# ======================================================================================

data modify storage datalib:input_validate scratch.rest set from storage datalib:input_validate scratch.value

# Strip one leading '-' if present (allowed once, at position 0 only).
execute store result score #DL.Len dl.tmp run data get storage datalib:input_validate scratch.rest
execute if score #DL.Len dl.tmp matches 0 run data modify storage datalib:input_validate result.error set value "empty input"
execute if score #DL.Len dl.tmp matches 0 run return 0

data modify storage datalib:input_validate scratch.first set string storage datalib:input_validate scratch.rest 0 1
execute if data storage datalib:input_validate {scratch:{first:"-"}} run data modify storage datalib:input_validate scratch.rest set string storage datalib:input_validate scratch.rest 1
data remove storage datalib:input_validate scratch.first

execute store result score #DL.Len dl.tmp run data get storage datalib:input_validate scratch.rest
execute if score #DL.Len dl.tmp matches 0 run data modify storage datalib:input_validate result.error set value "no digits after '-'"
execute if score #DL.Len dl.tmp matches 0 run return 0

function datalib:api/input/validate/_private/count_digits

execute if score #DL.DigitCount dl.tmp = #DL.Len dl.tmp run data modify storage datalib:input_validate result.valid set value 1b
execute unless score #DL.DigitCount dl.tmp = #DL.Len dl.tmp run data modify storage datalib:input_validate result.error set value "contains a non-digit character"

data remove storage datalib:input_validate scratch.rest
