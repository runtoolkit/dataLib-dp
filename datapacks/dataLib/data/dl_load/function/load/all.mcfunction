# Load — entry point called from minecraft:load tag via datalib:load
forceload add -30000000 1600

# Stage 0 — Preparing
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage0prep"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage0prep,limit=1] run say Preparing...
execute as @e[type=minecraft:marker,tag=datalib.stage0prep,limit=1] run kill @s

execute unless function dl_load:core/internal/load/validate run return 0

# Stage 1 debug
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage1"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage1,limit=1] run say Starting dataLib...
execute as @e[type=minecraft:marker,tag=datalib.stage1,limit=1] run kill @s

data modify storage datalib:engine _log_add_tmp.level set value "D.L."
data modify storage datalib:engine _log_add_tmp.message set value "Starting..."
data modify storage datalib:engine _log_add_tmp.color set value "aqua"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp

# RT Origin — Gate 1: watermark doğrulama
function datalib:_rt_origin
execute unless data storage datalib:engine {global:{rt_origin_verified:1b}} run return run tellraw @s {"text":"Exit code: 1 — rt_origin verification failed","color":"red"}

# RT Origin — Gate 2: fork kontrolü
# fork_verified field yoksa onay kapısını aç (1b=orijinal, 0b=fork onaylı, her ikisi de geçer)
execute unless data storage datalib:engine global.fork_verified run return run function dl_load:load/fork

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

function dl_load:load/dev_settings

function dl_load:load/other

data modify storage datalib:engine global.loaded set value 1b

function dl_load:core/internal/load/version_set

# Lantern Load integration — set pack version in load.status
# Format: (major * 10000) + (minor * 100) + patch
# Example: v2.2.6 = 20206
execute store result score #version_calc dl.tmp run scoreboard players get #dl.major dl.pre_version
scoreboard players operation #version_calc dl.tmp *= #601 dl.tmp
execute store result score #temp dl.tmp run scoreboard players get #dl.minor dl.pre_version
scoreboard players operation #temp dl.tmp *= #100 dl.tmp
scoreboard players operation #version_calc dl.tmp += #temp dl.tmp
scoreboard players operation #version_calc dl.tmp += #dl.patch dl.pre_version
scoreboard players operation #dataLib load.status = #version_calc dl.tmp

execute if score #dl.pre dl.pre_version matches 1.. run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loaded. ","color":"green"},[{"text":"v","color":"aqua"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"#ff8800","bold":true}]]
execute if score #dl.pre dl.pre_version matches ..0 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loaded. ","color":"green"},[{"text":"v","color":"aqua"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua","bold":true}]]

data modify storage datalib:engine _log_add_tmp.level set value "dataLib"
data modify storage datalib:engine _log_add_tmp.message set value "Loaded."
data modify storage datalib:engine _log_add_tmp.color set value "green"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp

# RT Origin verification
function datalib:_rt_origin
execute unless data storage datalib:engine {global:{rt_origin_verified:1b}} run return run tellraw @s {"text":"Exit code: 1 — rt_origin verification failed","color":"red"}

function dl_load:core/internal/load/finalize