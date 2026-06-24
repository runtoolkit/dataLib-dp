# Ensure this runs only for a valid player with an open dialog
# --- fixDatapack injected security guard ---
execute unless function datalib:debug/tools/utils/input_check run return 0
execute unless function datalib:core/security/cmd_gate run return 0
execute unless entity @s[scores={dl.perm_level=1..}] run return 0
# --- end fixDatapack injected security guard ---
execute unless entity @s[tag=datalib.dialog_opened] run return 0

# Notify all admins that a dialog has been opened
tellraw @a[tag=datalib.admin] ["",{"text":"[Dialog] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" opened a dialog.","color":"white"}]
