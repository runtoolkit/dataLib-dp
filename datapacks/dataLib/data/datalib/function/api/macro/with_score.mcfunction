# ─────────────────────────────────────────────
# datalib:api/macro/with_score [MACRO]
#
# Reads a player's scoreboard value and injects it as a named
# macro variable into the target function.
#
# Usage:
#   function datalib:engine/macro/with_score \
#     {func:"ns:path", player:"Name", objective:"myObj", var:"myVar"}
#
# Parameters:
#   func      — function to call (ns:path)
#   player    — target player name
#   objective — scoreboard objective
#   var       — macro variable name to inject into the target function
#
# Output: $(myVar) → scoreboard value (int)
# ─────────────────────────────────────────────

# Write score into pipe under the requested variable name
$execute store result storage datalib:engine _macro_pipe.$(var) int 1 run scoreboard players get $(player) $(objective)

# Call target function with pipe as macro source
$function $(func) with storage datalib:engine _macro_pipe

# Clear pipe
data remove storage datalib:engine _macro_pipe