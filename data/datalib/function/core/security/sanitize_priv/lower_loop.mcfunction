# ======================================================================================
# datalib:core/security/sanitize_priv/lower_loop
# ======================================================================================
#
# INTERNAL — do not call directly. Called only by sanitize.mcfunction Stage 1.
#
# Consumes datalib:output _sf.Remaining one character at a time, folding
# A-Z to a-z via literal comparison, appending each result to
# datalib:output _sf.Chars. Recurses until _sf.Remaining is empty.
#
# WHY LITERAL COMPARISON INSTEAD OF A LOOKUP TABLE:
#   stringlib:util/to_lowercase/fast depends on stringlib:zprivate/to_lowercase/
#   main_fast, which does not exist in this pack (only zprivate/concat and
#   zprivate/find are actually present — a real gap in what shipped).
#   A lookup-table approach would need runtime string slicing at a
#   score-computed offset, which vanilla's `data modify ... set string`
#   cannot do (start/end must be literal ints, not scores) — that would
#   require a macro sub-call per character. 26 literal comparisons avoid
#   that entirely: no macro indirection, no dependency on the missing
#   stringlib code, and every line is directly auditable.
#
# ======================================================================================

# Base case: nothing left to process
execute if data storage datalib:output {_sf:{Remaining:""}} run return 1

# Take the first character off _sf.Remaining, shrink Remaining by one
data modify storage datalib:output _sf.Char set string storage datalib:output _sf.Remaining 0 1
data modify storage datalib:output _sf.Remaining set string storage datalib:output _sf.Remaining 1

# Default: keep the character as-is unless an uppercase match below overrides it
data modify storage datalib:output _sf.Folded set from storage datalib:output _sf.Char

execute if data storage datalib:output {_sf:{Char:"A"}} run data modify storage datalib:output _sf.Folded set value "a"
execute if data storage datalib:output {_sf:{Char:"B"}} run data modify storage datalib:output _sf.Folded set value "b"
execute if data storage datalib:output {_sf:{Char:"C"}} run data modify storage datalib:output _sf.Folded set value "c"
execute if data storage datalib:output {_sf:{Char:"D"}} run data modify storage datalib:output _sf.Folded set value "d"
execute if data storage datalib:output {_sf:{Char:"E"}} run data modify storage datalib:output _sf.Folded set value "e"
execute if data storage datalib:output {_sf:{Char:"F"}} run data modify storage datalib:output _sf.Folded set value "f"
execute if data storage datalib:output {_sf:{Char:"G"}} run data modify storage datalib:output _sf.Folded set value "g"
execute if data storage datalib:output {_sf:{Char:"H"}} run data modify storage datalib:output _sf.Folded set value "h"
execute if data storage datalib:output {_sf:{Char:"I"}} run data modify storage datalib:output _sf.Folded set value "i"
execute if data storage datalib:output {_sf:{Char:"J"}} run data modify storage datalib:output _sf.Folded set value "j"
execute if data storage datalib:output {_sf:{Char:"K"}} run data modify storage datalib:output _sf.Folded set value "k"
execute if data storage datalib:output {_sf:{Char:"L"}} run data modify storage datalib:output _sf.Folded set value "l"
execute if data storage datalib:output {_sf:{Char:"M"}} run data modify storage datalib:output _sf.Folded set value "m"
execute if data storage datalib:output {_sf:{Char:"N"}} run data modify storage datalib:output _sf.Folded set value "n"
execute if data storage datalib:output {_sf:{Char:"O"}} run data modify storage datalib:output _sf.Folded set value "o"
execute if data storage datalib:output {_sf:{Char:"P"}} run data modify storage datalib:output _sf.Folded set value "p"
execute if data storage datalib:output {_sf:{Char:"Q"}} run data modify storage datalib:output _sf.Folded set value "q"
execute if data storage datalib:output {_sf:{Char:"R"}} run data modify storage datalib:output _sf.Folded set value "r"
execute if data storage datalib:output {_sf:{Char:"S"}} run data modify storage datalib:output _sf.Folded set value "s"
execute if data storage datalib:output {_sf:{Char:"T"}} run data modify storage datalib:output _sf.Folded set value "t"
execute if data storage datalib:output {_sf:{Char:"U"}} run data modify storage datalib:output _sf.Folded set value "u"
execute if data storage datalib:output {_sf:{Char:"V"}} run data modify storage datalib:output _sf.Folded set value "v"
execute if data storage datalib:output {_sf:{Char:"W"}} run data modify storage datalib:output _sf.Folded set value "w"
execute if data storage datalib:output {_sf:{Char:"X"}} run data modify storage datalib:output _sf.Folded set value "x"
execute if data storage datalib:output {_sf:{Char:"Y"}} run data modify storage datalib:output _sf.Folded set value "y"
execute if data storage datalib:output {_sf:{Char:"Z"}} run data modify storage datalib:output _sf.Folded set value "z"

# Append the (possibly folded) character to the running Chars list
data modify storage datalib:output _sf.Chars append from storage datalib:output _sf.Folded

function datalib:core/security/sanitize_priv/lower_loop
