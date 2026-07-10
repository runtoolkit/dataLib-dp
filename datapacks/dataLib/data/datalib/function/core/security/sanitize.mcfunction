# ======================================================================================
# datalib:core/security/sanitize
# ======================================================================================
#
# PURPOSE:
#   Normalize a raw input string before it reaches input_check's blocklist
#   comparisons, so that case variation and stray control characters cannot
#   be used to slip a payload past a literal-string match.
#
# THREAT THIS CLOSES:
#   input_check's Sections 8-19 compare `cmd` against literal lowercase
#   strings like "op ", "kick @a", "fill ". A caller submitting "OP ",
#   "Op ", "KICK @a" is byte-for-byte different from every blocklist entry
#   and passes straight through unmatched. Blocklists comparing raw
#   strings are defeated by case alone — a real bypass class.
#
# WHY THIS DOES NOT CALL stringlib:util/to_lowercase OR stringlib:util/replace:
#   Both depend on stringlib:zprivate/to_lowercase/* and zprivate/replace/*,
#   neither of which exists in this pack — only zprivate/concat and
#   zprivate/find are actually shipped. Calling either would silently no-op
#   (verified: see datalib:dltest diagnostic run). This function is
#   therefore self-contained: it walks the string one character at a time
#   using only native /data commands (no stringlib dependency at all for
#   the fold/strip step), then reassembles via the one stringlib primitive
#   confirmed working here, stringlib:util/concat.
#
# WHAT THIS DOES NOT DO:
#   Does not replace input_check — it's a pre-pass. Run it on `cmd` BEFORE
#   handing the result to any Section 8-19 comparison. Does NOT sanitize
#   `func` (function identifiers are case-sensitive namespace paths and
#   must never be lowercased).
#
# USAGE:
#   data modify storage datalib:input sanitize.String set value "<raw cmd>"
#   function datalib:core/security/sanitize
#   Output: storage datalib:output sanitize (normalized string)
#   Return: 1 always — this only normalizes, it does not reject.
#           Rejection stays input_check's job, run on the normalized output.
#
# PIPELINE (single pass, per character):
#   1. A-Z folded to a-z via literal comparison (sanitize_priv/lower_loop)
#   2. Backslash and `$` dropped in that same pass — no legitimate
#      blocklisted command needs either, and both are known techniques
#      for confusing string comparisons or macro re-interpretation
#      downstream ($function ... with storage ...).
#
# ======================================================================================

# Guard: if no input was provided, return an empty sanitized string rather
# than failing — callers should not need to special-case an absent field.
execute unless data storage datalib:input sanitize.String run data modify storage datalib:output sanitize set value ""
execute unless data storage datalib:input sanitize.String run return 1

# Seed the working state for lower_loop
data modify storage datalib:output _sf.Remaining set from storage datalib:input sanitize.String
data modify storage datalib:output _sf.Chars set value []

function datalib:core/security/sanitize_priv/lower_loop

# lower_loop leaves the folded characters as a list at _sf.Chars, e.g.
# ["o","p"," ","t","e","s","t"]. Filter out backslash and $ before concat —
# do this as a second pass over the list rather than during lower_loop, so
# lower_loop stays a pure case-fold and this stays a pure character filter.
data modify storage datalib:output _sf.Filtered set value []
function datalib:core/security/sanitize_priv/filter_loop

# Reassemble via the one stringlib primitive verified working in this pack.
data modify storage stringlib:input concat set from storage datalib:output _sf.Filtered
function stringlib:util/concat
data modify storage datalib:output sanitize set from storage stringlib:output concat

# Cleanup
data remove storage datalib:output _sf
data remove storage stringlib:input concat
data remove storage stringlib:output concat

return 1
