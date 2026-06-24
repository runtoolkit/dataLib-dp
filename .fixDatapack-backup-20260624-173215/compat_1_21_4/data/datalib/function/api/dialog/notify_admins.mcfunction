# Ensure this runs only for a valid player with an open dialog
execute unless entity @s[tag=datalib.dialog_opened] run return 0

# Notify all admins that a dialog has been opened
tellraw @a[tag=datalib.admin] ["",{"text":"[Dialog] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" opened a dialog.","color":"white"}]
