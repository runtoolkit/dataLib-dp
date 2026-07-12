# ======================================================================================
# datalib:core/security/sanitize_priv/filter_loop
# ======================================================================================
#
# INTERNAL — do not call directly. Called only by sanitize.mcfunction.
#
# Walks datalib:output _sf.Chars (a list of single-char strings produced by
# lower_loop) and copies every character except backslash and `$` into
# datalib:output _sf.Filtered, preserving order.
#
# Implementation note: NBT gives no native "list length" you can read into
# a score, so this does NOT try to compute one. Instead it probes index 0
# each iteration: since consumed elements are removed from the front, "does
# index 0 exist" is exactly the loop's continuation condition.
# ======================================================================================

# Base case: no elements left at the front of _sf.Chars
execute unless data storage datalib:output _sf.Chars[0] run return 1

data modify storage datalib:output _sf.cur set from storage datalib:output _sf.Chars[0]
data remove storage datalib:output _sf.Chars[0]

execute unless data storage datalib:output {_sf:{cur:"\\"}} unless data storage datalib:output {_sf:{cur:"$"}} run data modify storage datalib:output _sf.Filtered append from storage datalib:output _sf.cur

data remove storage datalib:output _sf.cur
function datalib:core/security/sanitize_priv/filter_loop
