# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/register_cmd
# Binds a raw command to a wand (carrot_on_a_stick).
#
# INPUT (storage datalib:input):
#   tag → custom_data tag name
#   cmd → raw command to run
# ─────────────────────────────────────────────────────────────────
execute unless data storage datalib:engine wand_binds run data modify storage datalib:engine wand_binds set value []
function datalib:core/internal/api/wand/register_cmd_do with storage datalib:input {}
