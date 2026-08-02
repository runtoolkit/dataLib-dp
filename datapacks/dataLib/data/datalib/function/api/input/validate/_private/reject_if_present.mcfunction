# ======================================================================================
# datalib:api/input/validate/_private/reject_if_present  [INTERNAL — macro function]
# ======================================================================================
# Called with {char: "<single char>"}. datalib:stringlib_data.input find.String and
# find.n are already set by the caller. Sets scratch.bad = 1b if this
# character occurs anywhere.
#
# NOTE: unlike count_one_digit, this is a presence check, not a count —
# find()'s own return value (1 if found, fail if not — see find.mcfunction's
# final line) is exactly what a presence check needs, so store success
# is used deliberately here rather than reading the output list.
# ======================================================================================

$data modify storage datalib:stringlib_data.input find.Find set value "$(char)"

execute store success score #DL.FindOk dl.tmp run function datalib:modules/string/api/legacy/find

execute if score #DL.FindOk dl.tmp matches 1 run data modify storage datalib:input_validate scratch.bad set value 1b
