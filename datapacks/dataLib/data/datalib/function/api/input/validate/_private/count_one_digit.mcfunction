# ======================================================================================
# datalib:api/input/validate/_private/count_one_digit  [INTERNAL — macro function]
# ======================================================================================
# Called with {digit: "0".."9"}. datalib:stringlib_data.input find.String is assumed
# already set by the caller (count_digits) to the string being scanned —
# reused here as replace.String too.
#
# Uses datalib:modules/string/api/legacy/replace(Find:"<digit>", Replace:"") instead of
# datalib:modules/string/api/legacy/find, because replace()'s return value is a genuine
# running match count (see zprivate/replace/*.mcfunction: ReturnValue is
# incremented once per match). find()'s own return value is NOT a count —
# it's "execute if data storage datalib:stringlib_data.output find[]", which is just
# 1-or-fail regardless of how many indices are in the list. replace()
# gives the real number directly, with no separate list-length step
# needed, and its side effect (datalib:stringlib_data.output replace) is harmless here
# since count_digits never reads that key.
# ======================================================================================

data modify storage datalib:stringlib_data.input replace.String set from storage datalib:stringlib_data.input find.String
$data modify storage datalib:stringlib_data.input replace.Find set value "$(digit)"
data modify storage datalib:stringlib_data.input replace.Replace set value ""
data modify storage datalib:stringlib_data.input replace.n set value 0

scoreboard players set #DL.FindHits dl.tmp 0
execute store result score #DL.FindHits dl.tmp run function datalib:modules/string/api/legacy/replace

scoreboard players operation #DL.DigitCount dl.tmp += #DL.FindHits dl.tmp
