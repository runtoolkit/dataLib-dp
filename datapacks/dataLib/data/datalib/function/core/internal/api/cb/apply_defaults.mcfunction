# datalib:api/cb/internal/apply_defaults
# Fills in missing x/y/z fields before the macro call.
execute unless data storage datalib:input cb.x run data modify storage datalib:input cb.x set value 0
execute unless data storage datalib:input cb.y run data modify storage datalib:input cb.y set value -64
execute unless data storage datalib:input cb.z run data modify storage datalib:input cb.z set value 0
