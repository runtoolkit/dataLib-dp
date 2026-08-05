# datalib:core/fallback/clear
# Clears the fallback state from datalib:output.
# Call this before an action chain to get a clean fallback check afterwards.
# Usage: function datalib:core/fallback/clear
data remove storage datalib:output fallback
