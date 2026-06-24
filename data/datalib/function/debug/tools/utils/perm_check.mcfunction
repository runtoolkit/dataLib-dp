# datalib:debug/tools/utils/perm_check
# Returns 1 if executor has sufficient dl.perm_level for admin commands.
# Returns 0 (+ fallback) if not.
#
# BREAKING CHANGE (v6.0.0): datalib.admin tag alone no longer grants access.
# Players must have dl.perm_level >= security.admin_min_level.
# Non-player callers (server/datapack) are trusted and pass through.
#
# Set player level:  function datalib:api/security/set_level {player:"Name",level:2}

# Non-players pass through (server-side / datapack callers are op-gated)
execute unless entity @s[type=minecraft:player] run return 1

# Load required admin level from security storage
execute store result score #perm_req dl.tmp run data get storage datalib:engine security.admin_min_level

# Check perm_level
execute if score @s dl.perm_level >= #perm_req dl.tmp run return 1

# Denied
function datalib:core/fallback/no_permission
return 0
