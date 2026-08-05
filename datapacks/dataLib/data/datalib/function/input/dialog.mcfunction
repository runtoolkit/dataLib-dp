# ======================================================================================
# datalib:input/dialog
# ======================================================================================
#
# TRIGGERED BY: #datalib:input/dialog function tag
#
# PURPOSE:
#   Opens datalib:input_prompt dialog for @s (must be run 'as' a player,
#   e.g. 'execute as <player> run function datalib:input/dialog', or bound
#   to a right-click/other trigger by the caller). Submitted text lands in
#   datalib:input_prompt's action, which macro-calls
#   datalib:input/private/dialog_capture — capture only, no execution.
#
# ASSUMPTION FLAGGED — CONFIRM WITH LEGENDS11:
#   This function assumes the caller decides WHEN to open the dialog
#   (e.g. right-click on an item, a command, an advancement). It is NOT
#   wired to any automatic trigger itself — I did not invent one since
#   none was specified.
# ======================================================================================

execute if entity @s[type=minecraft:player] run dialog show @s datalib:input_prompt
execute unless entity @s[type=minecraft:player] run return fail
