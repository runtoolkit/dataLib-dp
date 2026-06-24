# datalib:api/dialog/show
# Shows the dialog stored in datalib:engine dialog.DIALOG for the executing player.
# Requires Minecraft 1.21.6+ for the actual /dialog show command.
# On older versions this stub sets tag state and fires a version error.
#
# Pre-condition: caller must have written dialog data to:
#   datalib:engine dialog.DIALOG  (compound with at least "type" and "title" fields)
#
# The 1.21.6+ overlay overrides this with real dialog validation and show logic.
#
# BUGFIX v6.0.1: this file was missing from the base overlay entirely.
# Without it, any pack calling datalib:api/dialog/show on 1.20.3–1.21.5
# would get a "function not found" error instead of a clean version warning.

execute unless data storage datalib:engine dialog.DIALOG.type run return 0

scoreboard players set @s datalib.dialog_load -1
tag @s remove datalib.dialog_closed
tag @s remove datalib.dialog_opened
tag @s add datalib.dialog_opened

tellraw @s ["",{"text":"[DL] ","color":"aqua","bold":true},{"text":"Dialog: ","color":"gray"},{"nbt":"dialog.DIALOG.title","storage":"datalib:engine","color":"yellow"},{"text":" — ","color":"#555555"},{"text":"This feature requires Minecraft 1.21.6 or higher.","color":"red","italic":true}]

function datalib:api/dialog/notify_admins

return 1
