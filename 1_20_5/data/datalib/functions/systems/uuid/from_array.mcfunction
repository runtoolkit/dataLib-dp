# ============================================================
# datalib:systems/uuid/from_array
# Converts int array in datalib:input value to UUID string
#
# KULLANIM:
# data modify storage datalib:input value set value [I; a, b, c, d]
# function datalib:systems/uuid/from_array
#
# INPUT:
# datalib:input value → [I; int0, int1, int2, int3]
#
# OUTPUT:
# datalib:input value → "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#
# Output is written to datalib:input value (AME standard)
# ============================================================

# Read int[4] array directly from datalib:input value
execute store result score $uuid.0 dl.tmp run data get storage datalib:input value[0]
execute store result score $uuid.1 dl.tmp run data get storage datalib:input value[1]
execute store result score $uuid.2 dl.tmp run data get storage datalib:input value[2]
execute store result score $uuid.3 dl.tmp run data get storage datalib:input value[3]

# Split into 16 bytes → convert to hex chars → concatenate UUID string
function datalib:core/internal/systems/uuid/extract_bytes
function datalib:core/internal/systems/uuid/get_hexes with storage datalib:uuid _tmp
function datalib:core/internal/systems/uuid/concat with storage datalib:uuid _tmp
