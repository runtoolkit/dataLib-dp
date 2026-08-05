# ======================================================================================
# datalib:input/validate/_private/check_float  [INTERNAL]
# ======================================================================================
# Same digit-counting strategy as check_int, but first strips at most one
# '.' (anywhere after a possible leading '-', not at position 0 of rest,
# not as the last character either — "1." and ".5" are rejected as
# ambiguous rather than guessed at).
# ======================================================================================

data modify storage datalib:input_validate scratch.rest set from storage datalib:input_validate scratch.value

execute store result score #DL.Len dl.tmp run data get storage datalib:input_validate scratch.rest
execute if score #DL.Len dl.tmp matches 0 run data modify storage datalib:input_validate result.error set value "empty input"
execute if score #DL.Len dl.tmp matches 0 run return 0

# Count the dots via replace() — its return value is a real match count,
# unlike find()'s (see count_one_digit for why find()'s own return isn't
# usable as a count).
data modify storage stringlib:input replace.String set from storage datalib:input_validate scratch.rest
data modify storage stringlib:input replace.Find set value "."
data modify storage stringlib:input replace.Replace set value ""
data modify storage stringlib:input replace.n set value 0

scoreboard players set #DL.DotHits dl.tmp 0
execute store result score #DL.DotHits dl.tmp run function stringlib:util/replace

execute if score #DL.DotHits dl.tmp matches 2.. run data modify storage datalib:input_validate result.error set value "more than one '.'"
execute if score #DL.DotHits dl.tmp matches 2.. run return 0

# Exactly one dot: find its position (find()'s OUTPUT LIST is trustworthy —
# only its own return value isn't) and reject if it's first/last char.
execute if score #DL.DotHits dl.tmp matches 1 run data modify storage stringlib:input find.String set from storage datalib:input_validate scratch.rest
execute if score #DL.DotHits dl.tmp matches 1 run data modify storage stringlib:input find.Find set value "."
execute if score #DL.DotHits dl.tmp matches 1 run data modify storage stringlib:input find.n set value 1
execute if score #DL.DotHits dl.tmp matches 1 run function stringlib:util/find
execute if score #DL.DotHits dl.tmp matches 1 run function datalib:input/validate/_private/check_float_dot_position
execute if score #DL.DotHits dl.tmp matches 1 if data storage datalib:input_validate {result:{error:"malformed decimal point"}} run return 0

# Strip leading '-' the same way check_int does.
data modify storage datalib:input_validate scratch.first set string storage datalib:input_validate scratch.rest 0 1
execute if data storage datalib:input_validate {scratch:{first:"-"}} run data modify storage datalib:input_validate scratch.rest set string storage datalib:input_validate scratch.rest 1
data remove storage datalib:input_validate scratch.first

# Remove the single '.' itself before counting digits (it's not a digit,
# but it's the one non-digit char we're intentionally allowing).
execute if score #DL.DotHits dl.tmp matches 1 run function datalib:input/validate/_private/strip_one_dot

execute store result score #DL.Len dl.tmp run data get storage datalib:input_validate scratch.rest
execute if score #DL.Len dl.tmp matches 0 run data modify storage datalib:input_validate result.error set value "no digits"
execute if score #DL.Len dl.tmp matches 0 run return 0

function datalib:input/validate/_private/count_digits

execute if score #DL.DigitCount dl.tmp = #DL.Len dl.tmp run data modify storage datalib:input_validate result.valid set value 1b
execute unless score #DL.DigitCount dl.tmp = #DL.Len dl.tmp run data modify storage datalib:input_validate result.error set value "contains a non-digit character"

data remove storage datalib:input_validate scratch.rest
