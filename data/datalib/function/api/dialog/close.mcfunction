# datalib:api/dialog/close
# Closes the active dialog for the executing player and updates tag state.
# On versions below 1.21.5 there is no /dialog command, so we only update
# the tag state — the caller is responsible for clearing any open GUI
# through a version-appropriate mechanism (e.g. chest close packet).
# The 1.21.6+ overlay overrides this with a real "dialog clear @s" call.
#
# BUGFIX v6.0.1: moved version warning AFTER tag cleanup so that
# dialog_opened/dialog_closed state is always consistent regardless
# of the server version.

tag @s remove datalib.dialog_opened
tag @s add datalib.dialog_closed

tellraw @s {"text":"This feature requires 1.21.5 or higher!","color":"red","italic":false}
