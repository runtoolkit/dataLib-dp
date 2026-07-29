# ======================================================================================
# datalib:input/validate/_private/count_digits  [INTERNAL]
# ======================================================================================
# Requires scratch.rest to be set (the string to scan, already stripped of
# any leading sign/dot handling by the caller). Sets score
# #DL.DigitCount dl.tmp to the total number of '0'-'9' characters found
# in scratch.rest, using stringlib:util/find once per digit.
#
# Note on cost: this is 10 stringlib:util/find calls regardless of input
# length — flat cost, not per-character — which is what makes it cheap
# next to a recursive char-walk.
# ======================================================================================

scoreboard players set #DL.DigitCount dl.tmp 0

data modify storage stringlib:input find.String set from storage datalib:input_validate scratch.rest
data modify storage stringlib:input find.n set value 0

function datalib:input/validate/_private/count_one_digit {digit:"0"}
function datalib:input/validate/_private/count_one_digit {digit:"1"}
function datalib:input/validate/_private/count_one_digit {digit:"2"}
function datalib:input/validate/_private/count_one_digit {digit:"3"}
function datalib:input/validate/_private/count_one_digit {digit:"4"}
function datalib:input/validate/_private/count_one_digit {digit:"5"}
function datalib:input/validate/_private/count_one_digit {digit:"6"}
function datalib:input/validate/_private/count_one_digit {digit:"7"}
function datalib:input/validate/_private/count_one_digit {digit:"8"}
function datalib:input/validate/_private/count_one_digit {digit:"9"}
