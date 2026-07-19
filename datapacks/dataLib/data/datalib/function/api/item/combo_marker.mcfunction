# datalib:api/item/combo_marker
#
# Stamps a consecutive-use counter under minecraft:custom_data.dataLib.combo
# on the target's held item — for "combo" mechanics (e.g. bonus effects
# after N consecutive uses without switching items). Mojang tracks no
# per-item use streak; this is purely datapack-side bookkeeping. Preserves
# any other dataLib fields already on the item.
#
# Call:
#   function datalib:api/item/combo_marker {player:"Steve",slot:"weapon.mainhand",combo:3}
#
# Callers are responsible for incrementing/resetting "combo" between calls
# (e.g. via a player-scoped scoreboard objective) — this function only
# writes the given value onto the item, it does not track state itself.

data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage datalib:output found set value 1b

$data modify storage datalib:_item_tmp player set value "$(player)"
function datalib:api/item/internal/read_datalib_compound with storage datalib:_item_tmp

$data modify storage datalib:_item_tmp dataLib.combo set value $(combo)
$data modify storage datalib:_item_tmp slot set value "$(slot)"

function datalib:api/item/internal/combo_marker_apply with storage datalib:_item_tmp
