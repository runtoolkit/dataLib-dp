# datalib:api/dialog/open [1.20.3 overlay]
# Opens the dialog stored in datalib:engine dialog.DIALOG for the executing player.
# /dialog command requires 1.21.6+ — this stub sets tag state and fires a version error.
#
# BUGFIX v6.0.1: guard was checking for the ambiguous "dialog.DIALOG" compound path.
# Fixed to check "dialog.DIALOG.type" which is always required and semantically clear.

execute unless data storage datalib:engine dialog.DIALOG.type run return 0

scoreboard players set @s datalib.dialog_load -1
tag @s remove datalib.dialog_closed
tag @s remove datalib.dialog_opened
tag @s add datalib.dialog_opened

tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"aqua","bold":true},{"text":"Dialog: ","color":"gray"},{"nbt":"dialog.DIALOG.title","storage":"datalib:engine","color":"yellow"},{"text":" — ","color":"#555555"},{"text":"This feature requires Minecraft 1.21.6 or higher.","color":"red","italic":true}]}

function datalib:api/dialog/notify_admins

return 1
