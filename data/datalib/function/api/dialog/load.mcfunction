# datalib:api/dialog/load
# Registers a dialog cooldown for the executing player.
# Requires Minecraft 1.21.6+ for the actual /dialog command.
# On older versions this stub updates the scoreboard state for caller
# compatibility and fires a version error — no dialog is shown.
#
# Usage (1.21.6+ overlay handles actual dialog loading):
#   data modify storage datalib:input cooldown set value 20
#   function datalib:api/dialog/load
#
# BUGFIX v6.0.1: previously this file was a dead stub (return run tellraw)
# with no scoreboard update — callers expecting dl.dialog_load to be set
# would silently get stale values. Now we set the fallback value before
# emitting the version error so state is always consistent.

execute unless data storage datalib:input cooldown run data modify storage datalib:input cooldown set value 20
execute store result score @s datalib.dialog_load run data get storage datalib:input cooldown

tellraw @s {"text":"This feature requires 1.21.5 or higher!","color":"red","italic":false}
