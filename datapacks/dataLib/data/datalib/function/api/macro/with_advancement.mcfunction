# ─────────────────────────────────────────────
# datalib:api/macro/with_advancement [MACRO]
#
# Checks whether a player has completed a specific advancement and
# injects the boolean result as a named macro variable into the target function.
#
# Usage:
#   function datalib:engine/macro/with_advancement \
#     {func:"ns:path", player:"Name", advancement:"ns:adv/path", var:"done"}
#
# Parameters:
#   func        — function to call (ns:path)
#   player      — target player name
#   advancement — advancement to check (ns:path/to/adv)
#   var         — macro variable name to inject into the target function
#
# Output: $(done) → 1b (completed) or 0b (not completed)
# ─────────────────────────────────────────────

# Clear pipe
data remove storage datalib:engine _macro_pipe

# Default: not completed
$data modify storage datalib:engine _macro_pipe.$(var) set value "empty"

# Set to 1b if the player has completed the advancement
$execute as @a[name=$(player),limit=1,advancements={$(advancement)=true}] run data modify storage datalib:engine _macro_pipe.$(var) set value 1b
$execute as @a[name=$(player),limit=1,advancements={$(advancement)=false}] run data modify storage datalib:engine _macro_pipe.$(var) set value 0b

# Call target function with pipe as macro source
$function $(func) with storage datalib:engine _macro_pipe