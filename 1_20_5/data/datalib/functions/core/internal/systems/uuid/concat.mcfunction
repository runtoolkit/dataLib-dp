# ============================================================
# datalib:core/internal/systems/uuid/concat [MACRO FUNCTION]
# Builds a standard UUID string from 16 hex field values
#
# Call: function datalib:core/internal/systems/uuid/concat with storage datalib:uuid _tmp
# Output: datalib:input value → "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#
# UUID byte order (big-endian):
# Segment 1 (8 hex): int0 MSB→LSB = [3][2][1][0]
# Segment 2 (4 hex): int1 MSB→LSB = [7][6]
# Segment 3 (4 hex): int1 continued = [5][4]
# Segment 4 (4 hex): int2 MSB→LSB = [b][a]
# Segment 5 (12 hex): int2 continued + int3 = [9][8][f][e][d][c]
# ============================================================
$data modify storage datalib:input value set value "$(3)$(2)$(1)$(0)-$(7)$(6)-$(5)$(4)-$(b)$(a)-$(9)$(8)$(f)$(e)$(d)$(c)"
