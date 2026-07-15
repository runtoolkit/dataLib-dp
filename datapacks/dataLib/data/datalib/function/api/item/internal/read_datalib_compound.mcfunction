# datalib:api/item/internal/read_datalib_compound
# Internal — do not call directly.
#
# Reads the MAIN HAND item's existing minecraft:custom_data.dataLib compound
# into storage datalib:_item_tmp dataLib, defaulting to {} if absent. Every
# api/item/* function calls this before writing, so that set_components
# never clobbers fields written by a different api/item/* call. This is the
# one piece shared across all five field-setters below (the field name
# itself must stay a literal in each caller's own JSON body, since macro
# variables cannot substitute NBT compound KEYS — only values).
#
# Expects: {player:"..."}
# Produces: storage datalib:_item_tmp dataLib

data modify storage datalib:_item_tmp dataLib set value {}
$execute as @a[name=$(player),limit=1] run data modify storage datalib:_item_tmp dataLib set from entity @s SelectedItem.components."minecraft:custom_data".dataLib
