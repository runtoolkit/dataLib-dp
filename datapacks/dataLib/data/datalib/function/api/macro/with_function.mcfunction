# ─────────────────────────────────────────────
# datalib:api/macro/with_function [MACRO]
#
# Runs a provider (source) function; passes the data that function
# wrote to datalib:engine _macro_pipe storage as macro variable source
# to a consumer (target) function.
#
# Establishes a type-safe data bridge between two functions.
#
# Usage:
#   function datalib:engine/macro/with_function \
#     {source:"ns:provider", target:"ns:consumer"}
#
# Parameters:
#   source — function that produces data and writes it to datalib:engine _macro_pipe
#   target — function that consumes data from the pipe as macro variables
#
# Contract:
#   source function must write its output to this storage:
#     data modify storage datalib:engine _macro_pipe.<key> set value <val>
#   target function can access those keys as $(key).
# ─────────────────────────────────────────────

# Run provider function — it writes its output to _macro_pipe
$function $(source)

# Pass pipe to consumer as macro source
$function $(target) with storage datalib:engine _macro_pipe

# Clear pipe before source runs
data remove storage datalib:engine _macro_pipe