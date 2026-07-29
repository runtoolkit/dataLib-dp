# ======================================================================================
# datalib:input/validate/_private/count_one_digit  [INTERNAL — macro function]
# ======================================================================================
# Called with {digit: "0".."9"}. stringlib:input find.String is assumed
# already set by the caller (count_digits) to the string being scanned —
# reused here as replace.String too.
#
# Uses stringlib:util/replace(Find:"<digit>", Replace:"") instead of
# stringlib:util/find, because replace()'s return value is a genuine
# running match count (see zprivate/replace/*.mcfunction: ReturnValue is
# incremented once per match). find()'s own return value is NOT a count —
# it's "execute if data storage stringlib:output find[]", which is just
# 1-or-fail regardless of how many indices are in the list. replace()
# gives the real number directly, with no separate list-length step
# needed, and its side effect (stringlib:output replace) is harmless here
# since count_digits never reads that key.
# ======================================================================================

data modify storage stringlib:input replace.String set from storage stringlib:input find.String
$data modify storage stringlib:input replace.Find set value "$(digit)"
data modify storage stringlib:input replace.Replace set value ""
data modify storage stringlib:input replace.n set value 0

scoreboard players set #DL.FindHits dl.tmp 0
execute store result score #DL.FindHits dl.tmp run function stringlib:util/replace

scoreboard players operation #DL.DigitCount dl.tmp += #DL.FindHits dl.tmp
