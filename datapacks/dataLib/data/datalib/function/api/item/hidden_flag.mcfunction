# datalib:api/item/hidden_flag
#
# Appends a named boolean flag to minecraft:custom_data.dataLib.flags on the
# target's held item. custom_data never renders in the tooltip and has no
# vanilla equivalent as a general-purpose flag bag — this gives datapacks a
# namespaced place to store item-specific booleans (e.g. "quest_item",
# "soulbound", "no_drop") without colliding with other packs' custom_data
# use. Preserves any other dataLib fields already on the item.
#
# IMPLEMENTATION NOTE: macro variables ($(key)) can only be substituted as
# VALUES, never as NBT compound KEYS — Minecraft has no syntax for a dynamic
# key name inside a macro line (a known, still-open engine limitation, not
# a workaround choice). So "flags" is a list of {name:"...",value:1b}
# entries rather than a compound keyed by flag name; "name" is a value
# here, not a key, so it interpolates fine.
#
# Call:
#   function datalib:api/item/hidden_flag {player:"Steve",slot:"weapon.mainhand",name:"soulbound",value:1b}
#
# NOTE: appends — does not de-duplicate by name. If you set the same flag
# name twice, both entries persist; readers should treat the LAST matching
# entry as authoritative if that matters for your use case.

data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage datalib:output found set value 1b

$data modify storage datalib:_item_tmp player set value "$(player)"
function datalib:api/item/internal/read_datalib_compound with storage datalib:_item_tmp

execute unless data storage datalib:_item_tmp dataLib.flags run data modify storage datalib:_item_tmp dataLib.flags set value []
data modify storage datalib:_item_tmp dataLib.flags append value {}
$data modify storage datalib:_item_tmp dataLib.flags[-1].name set value "$(name)"
$data modify storage datalib:_item_tmp dataLib.flags[-1].value set value $(value)

$data modify storage datalib:_item_tmp slot set value "$(slot)"

function datalib:api/item/internal/hidden_flag_apply with storage datalib:_item_tmp
