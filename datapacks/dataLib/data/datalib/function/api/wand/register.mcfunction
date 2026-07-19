# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/register
# Registers a wand with a specific custom_data tag.
# On every item use, $(func) or $(cmd) runs.
#
# INPUT (storage datalib:input):
#   tag  → custom_data tag name (e.g. "my_wand")
#   func → (optional) function to run
#   cmd  → (optional) command to run (if no func)
#
# USAGE:
#   data modify storage datalib:input tag set value "fire_wand"
#   data modify storage datalib:input func set value "mypack:on_fire_wand"
#   function datalib:api/wand/register with storage datalib:input {}
# ─────────────────────────────────────────────────────────────────
execute unless data storage datalib:engine wand_binds run data modify storage datalib:engine wand_binds set value []
function datalib:core/internal/api/wand/register_do with storage datalib:input {}
