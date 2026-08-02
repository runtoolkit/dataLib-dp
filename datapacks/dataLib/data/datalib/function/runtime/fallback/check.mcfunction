# datalib:runtime/fallback/check
# Returns 1 if a fallback was triggered in the last call, 0 otherwise.
# Usage:
#   function datalib:runtime/fallback/clear
#   function ns:your/action
#   execute if data storage datalib:output fallback{triggered:1b} run function ns:handle_failure
#   function datalib:runtime/fallback/check   ← or use this for return-based checks
execute if data storage datalib:output fallback{triggered:1b} run return 1
return 0
