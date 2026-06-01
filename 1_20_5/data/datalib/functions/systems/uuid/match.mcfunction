# ============================================================
# datalib:systems/uuid/match
# Compares @s entity's UUID with datalib:input value
# If matched, runs datalib:input func function
#
# KULLANIM:
# data modify storage datalib:input value set value "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# data modify storage datalib:input func set value "mynamespace:my_function"
# execute as <entity> run function datalib:systems/uuid/match
#
# INPUT:
# datalib:input value → UUID string to compare (expected)
# datalib:input func → function to run if matched
#
# NOTE: func is run in the same entity context.
# ============================================================

# Save expected UUID string to temporary field
# (from_entity call overwrites datalib:input value)
data modify storage datalib:uuid _match_target set from storage datalib:input value

# Convert @s UUID to string → datalib:input value
function datalib:systems/uuid/from_entity

# Compare: if matched, run func
# Is the current UUID (datalib:input value) equal to the expected?
function datalib:core/internal/systems/uuid/match_check with storage datalib:engine
