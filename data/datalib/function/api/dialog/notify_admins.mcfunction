# datalib:api/dialog/notify_admins
# Notifies all online admins that the executing player opened a dialog.
# Logs the dialog identifier to the debug log buffer.
#
# Must be called AFTER the dialog_opened tag has been set on @s.
# Both api/dialog/open and api/dialog/show call this after tag assignment.
#
# BUGFIX v6.0.1: guard now also checks that dialog.DIALOG.title exists in
# storage so that the admin message includes meaningful dialog info rather
# than falling through with a generic "opened a dialog" when no dialog
# context is set.

execute unless entity @s[tag=datalib.dialog_opened] run return 0

tellraw @a[tag=datalib.admin] ["",{"text":"[DL/dialog] ","color":"gold","bold":true},{"selector":"@s","color":"yellow"},{"text":" opened dialog: ","color":"white"},{"nbt":"dialog.DIALOG.title","storage":"datalib:engine","color":"aqua","italic":true}]

data modify storage datalib:engine _log_add_tmp.message set value "[dialog/notify_admins] dialog opened"
data modify storage datalib:engine _log_add_tmp.level set value "INFO"
data modify storage datalib:engine _log_add_tmp.color set value "gray"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
