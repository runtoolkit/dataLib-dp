# dl_load:resolve/version
# Resolves whether stale dl.pre_version scores (left over from a
# previous load pass in the same server session) match this build's
# expected version. Returns 1 → match / not yet set (proceed).
# Returns 0 → mismatch (version_warn fired, load aborted upstream).
#
# EXPECTED (v6.0.1-pre2): major=6 minor=0 patch=1 pre=2
#
# BUGFIX (v6.0.1-pre2): the previous check compared #dl.pre against
# "matches 1.." (i.e. "any pre >= 1 counts as mismatch"), which made
# this objective self-defeating — the pack's own expected pre value
# is >= 1, so a *correctly* stamped scoreboard from a prior pass in
# this session would still trip the mismatch flag. This now compares
# against the exact expected pre value like every other component.

scoreboard objectives add dl.pre_version dummy
scoreboard players set #dl.mismatch dl.pre_version 0

# Only meaningful once a previous pass has actually stamped values
# (#dl.ver_set is set by core/internal/load/version_set).
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.major dl.pre_version matches 6 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.minor dl.pre_version matches 0 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.patch dl.pre_version matches 1 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.pre dl.pre_version matches 2 run scoreboard players set #dl.mismatch dl.pre_version 1

execute if score #dl.mismatch dl.pre_version matches 1 run function dl_load:core/internal/load/version_warn
execute if score #dl.mismatch dl.pre_version matches 1 run return 0

return 1
