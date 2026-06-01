# datalib:core/internal/api/dialog/load_exec [1.20.5 overlay]
# Stub — /dialog command requires 1.21.6+.
# Sets the expected scoreboard/tag state for caller compatibility.
$scoreboard players set @s datalib.dialog_load $(cooldown)
tag @s remove datalib.dialog_opened
tag @s add datalib.dialog_opened
tag @s add datalib.dialog_closed
