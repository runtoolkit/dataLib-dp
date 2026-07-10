# datalib:api/dialog/show_macro
# Shows a dialog from inline JSON stored in datalib:engine dialog.DATA.
# Requires Minecraft 1.21.6+ (pack_format 80+).
# On older versions this stub fires a friendly error message.
#
# Usage (1.21.6+ overlay handles actual logic):
#   data modify storage datalib:engine dialog.DATA set value '{...}'
#   function datalib:api/dialog/show_macro
#
# BUGFIX v6.0.1: this file was missing from the base overlay entirely.
# Without it, any pack calling datalib:api/dialog/show_macro on 1.20.3–1.21.5
# would get a "function not found" error instead of a clean version warning.

tellraw @s {"text":"This feature requires Minecraft 1.21.6 or higher!","color":"red","italic":false}
