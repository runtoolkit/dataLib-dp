# ─────────────────────────────────────────────────────────────────
# datalib:api/dialog/show [1.21.6+ overlay]
# Shows the dialog stored at datalib:engine dialog.DIALOG as inline JSON.
# Called by dialog/open after validation.
# Uses show_macro_exec to pipe DIALOG compound as inline dialog.
# ─────────────────────────────────────────────────────────────────

execute if entity @s[tag=datalib.dialog_opened] at @s run return 0
execute unless data storage datalib:engine dialog.DIALOG run return 0

execute at @s run function datalib:player/get_name
data modify storage datalib:engine dialog.NAME set from storage datalib:names temp.NAME

function datalib:api/dialog/internal/show_dialog_exec with storage datalib:engine dialog

tag @s add datalib.dialog_opened

return 1
