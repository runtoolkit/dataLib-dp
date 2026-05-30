# Load — entry point called from minecraft:load tag via datalib:load
forceload add -30000000 1600

# Stage 1 debug
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage1"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage1,limit=1] run say Starting dataLib...
execute as @e[type=minecraft:marker,tag=datalib.stage1,limit=1] run kill @s

execute unless function dl_load:load/internal/validate run return 0

data modify storage datalib:input level set value "D.L."
data modify storage datalib:input message set value "Starting..."
data modify storage datalib:input color set value "aqua"
function datalib:systems/log/add with storage datalib:input {}

# Stage 2 debug
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage2"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage2,limit=1] run say Loading scoreboards...
execute as @e[type=minecraft:marker,tag=datalib.stage2,limit=1] run kill @s
function dl_load:load/scoreboards

# Stage 3 debug
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage3"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage3,limit=1] run say Loading storages...
execute as @e[type=minecraft:marker,tag=datalib.stage3,limit=1] run kill @s
function dl_load:load/storages

function dl_load:load/other

data modify storage datalib:engine global.loaded set value 1b

function dl_load:load/internal/version_set

# Lantern Load integration — set pack version in load.status
# Format: (major * 10000) + (minor * 100) + patch
# Example: v2.2.6 = 20206
execute store result score #version_calc dl.tmp run scoreboard players get #dl.major dl.pre_version
scoreboard players operation #version_calc dl.tmp *= #10000 dl.tmp
execute store result score #temp dl.tmp run scoreboard players get #dl.minor dl.pre_version
scoreboard players operation #temp dl.tmp *= #100 dl.tmp
scoreboard players operation #version_calc dl.tmp += #temp dl.tmp
scoreboard players operation #version_calc dl.tmp += #dl.patch dl.pre_version
scoreboard players operation #dataLib load.status = #version_calc dl.tmp

execute if score #dl.pre dl.pre_version matches 1.. run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loaded. ","color":"green"},[{"text":"v","color":"aqua"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"#ff8800","bold":true}]]
execute if score #dl.pre dl.pre_version matches ..0 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loaded. ","color":"green"},[{"text":"v","color":"aqua"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua","bold":true}]]

data modify storage datalib:input level set value "dataLib"
data modify storage datalib:input message set value "Loaded."
data modify storage datalib:input color set value "green"
function datalib:systems/log/add with storage datalib:input {}

function dl_load:load/internal/finalize