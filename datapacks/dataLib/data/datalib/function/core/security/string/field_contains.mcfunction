# ======================================================================================
# datalib:core/security/string/field_contains
# ======================================================================================
#
# PURPOSE:
#   Macro wrapper around datalib:core/security/string/contains, specialized
#   for testing a single field of `datalib:output inputs` (i.e. `func` or
#   `cmd`) against one literal substring. This is what every blocklist/
#   allowlist line in input_check now calls instead of the old (broken)
#   NBT-equality `execute if data storage datalib:output inputs{field:"x"}`.
#
# USAGE (macro call):
#   function datalib:core/security/string/field_contains {field:"cmd",needle:"op "}
#   Return: 1 if inputs.<field> contains <needle> anywhere, 0 otherwise
#           (also 0 if the field is absent/unset).
#   Output: score #DL.StrFound dl.tmp, score #DL.StrIndex dl.tmp (see contains.mcfunction)
#
# Field is read with $(field) storage indirection via a `with storage`
# macro on the snapshot already isolated in Section 3, so this never
# touches datalib:input.
# ======================================================================================

$data modify storage stringlib:input find.String set from storage datalib:output inputs.$(field)
$data modify storage stringlib:input find.Find set value "$(needle)"

# Guard: if the field itself is absent, treat as "not found" without
# invoking StringLib (find.String would carry a stale/empty value).
execute unless data storage datalib:output inputs.$(field) run scoreboard players set #DL.StrFound dl.tmp 0
execute unless data storage datalib:output inputs.$(field) run scoreboard players set #DL.StrIndex dl.tmp -1
execute unless data storage datalib:output inputs.$(field) run data remove storage stringlib:input find
execute unless data storage datalib:output inputs.$(field) run return 0

function datalib:core/security/string/contains

execute if score #DL.StrFound dl.tmp matches 1 run return 1
return 0
