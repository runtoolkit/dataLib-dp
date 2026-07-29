# ======================================================================================
# datalib:input/validate/_private/strip_one_dot  [INTERNAL]
# ======================================================================================
# Removes exactly one '.' from scratch.rest (already confirmed to contain
# exactly one, at a valid non-edge position) via stringlib:util/replace,
# leaving the digit characters ready for count_digits.
# ======================================================================================

data modify storage stringlib:input replace.String set from storage datalib:input_validate scratch.rest
data modify storage stringlib:input replace.Find set value "."
data modify storage stringlib:input replace.Replace set value ""
data modify storage stringlib:input replace.n set value 1

function stringlib:util/replace
data modify storage datalib:input_validate scratch.rest set from storage stringlib:output replace
