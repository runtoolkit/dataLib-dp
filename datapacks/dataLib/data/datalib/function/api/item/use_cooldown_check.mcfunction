# datalib:api/item/use_cooldown_check
#
# Reads minecraft:custom_data.dataLib.cooldown_until from the target's
# MAIN HAND item and reports whether it has expired.
#
# LIMITATION: only the main-hand slot is supported here. "weapon.mainhand" is
# a slot argument valid for /item, /give, and "execute if items" — it is NOT
# a valid /data get NBT path. Reading a specific item's NBT by path requires
# the SelectedItem tag (main hand only) or Inventory[{Slot:N}] for other
# slots. Extending this to arbitrary slots needs a slot->index lookup table
# and is out of scope for this pass.
#
# Call:
#   function datalib:api/item/use_cooldown_check {player:"Steve"}
#
# Output:
#   datalib:output found     -> 1b if player found
#   datalib:output ready     -> 1b if cooldown has expired (or was never set)
#   datalib:output remaining -> ticks remaining (0 if ready)

data modify storage datalib:output found set value 0b
data modify storage datalib:output ready set value 0b
data modify storage datalib:output remaining set value 0

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage datalib:output found set value 1b

# Reset to 0 first: if the item has no cooldown_until path yet, the "data
# get" below fails and would otherwise leave a stale score from a prior call.
scoreboard players set #dl_item_expiry dl.tmp 0
execute store result score #dl_item_now dl.tmp run time query gametime
$execute as @a[name=$(player),limit=1] store result score #dl_item_expiry dl.tmp run data get entity @s SelectedItem.components."minecraft:custom_data".dataLib.cooldown_until

execute if score #dl_item_now dl.tmp >= #dl_item_expiry dl.tmp run data modify storage datalib:output ready set value 1b
execute unless score #dl_item_now dl.tmp >= #dl_item_expiry dl.tmp run scoreboard players operation #dl_item_remaining dl.tmp = #dl_item_expiry dl.tmp
execute unless score #dl_item_now dl.tmp >= #dl_item_expiry dl.tmp run scoreboard players operation #dl_item_remaining dl.tmp -= #dl_item_now dl.tmp
execute unless score #dl_item_now dl.tmp >= #dl_item_expiry dl.tmp store result storage datalib:output remaining int 1 run scoreboard players get #dl_item_remaining dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"item/use_cooldown_check ","color":"aqua"},{"text":"$(player)","color":"white"}]
