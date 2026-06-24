# datalib:api/dialog/close [1.20.3 overlay]
# Closes the active dialog for the executing player and updates tag state.
# No /dialog command exists on this version — we only fix the tag state.
# The 1.21.6+ overlay overrides this with a real "dialog clear @s" call.
#
# BUGFIX v6.0.1: moved version warning AFTER tag cleanup so that
# dialog_opened/dialog_closed state is always consistent regardless
# of the server version.

tag @s remove datalib.dialog_opened
tag @s add datalib.dialog_closed

tellraw @s {"text":"This feature requires 1.21.5 or higher!","color":"red","italic":false}
