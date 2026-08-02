# ======================================================================================
# datalib:api/input/validate/_private/strip_one_dot  [INTERNAL]
# ======================================================================================
# Removes exactly one '.' from scratch.rest (already confirmed to contain
# exactly one, at a valid non-edge position) via datalib:modules/string/api/legacy/replace,
# leaving the digit characters ready for count_digits.
# ======================================================================================

data modify storage datalib:stringlib_data.input replace.String set from storage datalib:input_validate scratch.rest
data modify storage datalib:stringlib_data.input replace.Find set value "."
data modify storage datalib:stringlib_data.input replace.Replace set value ""
data modify storage datalib:stringlib_data.input replace.n set value 1

function datalib:modules/string/api/legacy/replace
data modify storage datalib:input_validate scratch.rest set from storage datalib:stringlib_data.output replace
