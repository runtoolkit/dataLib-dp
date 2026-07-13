data remove storage datalib:names temp

setblock 0 300 0 black_shulker_box replace

loot insert 0 300 0 loot datalib:player/head

data modify storage datalib:names temp.NAME set from block 0 300 0 Items[0].components."minecraft:profile".name

data modify storage datalib:names temp.UUID insert 0 from entity @s UUID[0]
data modify storage datalib:names temp.UUID insert 1 from entity @s UUID[1]
data modify storage datalib:names temp.UUID insert 2 from entity @s UUID[2]
data modify storage datalib:names temp.UUID insert 3 from entity @s UUID[3]

setblock 0 300 0 air replace