# Blok bulundu!
# Increment hook.placed scoreboard
scoreboard players add @s datalib.hook_placed 1

# Write to hook event storage (other systems can listen)
# Save block coordinates (via marker summon from positioned context)
summon minecraft:marker ~ ~ ~ {Tags:["macro.hook_block_pos"]}
execute store result storage datalib:hook placed.x int 1 run data get entity @e[type=minecraft:marker,tag=datalib.hook_block_pos,limit=1] Pos[0]
execute store result storage datalib:hook placed.y int 1 run data get entity @e[type=minecraft:marker,tag=datalib.hook_block_pos,limit=1] Pos[1]
execute store result storage datalib:hook placed.z int 1 run data get entity @e[type=minecraft:marker,tag=datalib.hook_block_pos,limit=1] Pos[2]
kill @e[type=minecraft:marker,tag=datalib.hook_block_pos,limit=1]

# Timestamp kaydet (datalib.time skorundan)
execute store result storage datalib:hook placed.tick int 1 run scoreboard players get #time datalib.time

# Get player UUID and name via dataLib modules
execute as @s run function datalib:systems/uuid/from_entity
data modify storage datalib:hook placed.uuid set from storage datalib:input value

execute as @s run function datalib:player/get_name
data modify storage datalib:hook placed.name set from storage datalib:names temp.NAME
data modify storage datalib:hook placed.uuid_array set from storage datalib:names temp.UUID

# Hook event flag'ini set et
data modify storage datalib:hook placed.active set value 1b

# Hook event sistemine "placed_block" event'i fire et
data modify storage datalib:engine _hook_fire_tmp set value {event:"placed_block"}
execute as @s run function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp

# Legacy event system support (if present)
execute if score #m_hook datalib.Flags matches 1.. run function datalib:events/fire {id:"hook.placed"}

# Cleanup: reset counter
scoreboard players reset @s dl.tmp
