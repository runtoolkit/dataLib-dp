# datalib:api/item/use_cooldown
#
# Stamps a per-item custom cooldown expiry tick under
# minecraft:custom_data.dataLib.cooldown_until — independent of vanilla's
# shared "/cooldown" system (which is per-item-type, not per-item-instance).
# Preserves any other dataLib fields already on the item.
#
# Call:
#   function datalib:api/item/use_cooldown {player:"Steve",slot:"weapon.mainhand",ticks:100}
#
# "ticks" is an offset added to the current world time; stored as an
# absolute expiry tick so checking it later is a single comparison
# (see api/item/use_cooldown_check).

data modify storage datalib:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage datalib:output found set value 1b

# Compute absolute expiry tick = current gametime + requested offset
execute store result score #dl_item_now dl.tmp run time query gametime
$scoreboard players add #dl_item_now dl.tmp $(ticks)
execute store result storage datalib:_item_tmp expiry int 1 run scoreboard players get #dl_item_now dl.tmp

$data modify storage datalib:_item_tmp player set value "$(player)"
function datalib:api/item/internal/read_datalib_compound with storage datalib:_item_tmp

data modify storage datalib:_item_tmp dataLib.cooldown_until set from storage datalib:_item_tmp expiry
$data modify storage datalib:_item_tmp slot set value "$(slot)"

function datalib:api/item/internal/use_cooldown_apply with storage datalib:_item_tmp
