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

# RT Origin — Gate 1: watermark doğrulama (artık validate içinde çağrılıyor, burada tekrar çağırmaya gerek yok)
execute unless data storage datalib:engine {global:{rt_origin_verified:1b}} run return run tellraw @s {"text":"Exit code: 1 — rt_origin verification failed","color":"red"}

# RT Origin — Gate 2: fork check
# If fork_verified field doesn't exist, open the approval gate (1b=original, 0b=fork approved, either passes)
execute unless data storage datalib:engine global.fork_verified run return run function dl_load:load/fork

summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage1b"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage1b,limit=1] run say Fork gate passed...
execute as @e[type=minecraft:marker,tag=datalib.stage1b,limit=1] run kill @s

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

summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage4"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage4,limit=1] run say Loading other systems...
execute as @e[type=minecraft:marker,tag=datalib.stage4,limit=1] run kill @s

function dl_load:load/other
data modify storage datalib:engine global.loaded set value 1b

function dl_load:core/internal/load/version_set

summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage5"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage5,limit=1] run say Setting version...
execute as @e[type=minecraft:marker,tag=datalib.stage5,limit=1] run kill @s

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

# RT Origin verification (flag already set by validate at start of load)
execute unless data storage datalib:engine {global:{rt_origin_verified:1b}} run return run tellraw @s {"text":"Exit code: 1 — rt_origin verification failed","color":"red"}

summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage6"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage6,limit=1] run say Finalizing...
execute as @e[type=minecraft:marker,tag=datalib.stage6,limit=1] run kill @s

function dl_load:core/internal/load/finalize

# Detect datalib_extensions
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage7"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage7,limit=1] run say Finding datalib_extensions...
execute as @e[type=minecraft:marker,tag=datalib.stage7,limit=1] run kill @s

execute if score #datalib_extensions.present datalib.meta matches 1.. run summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage8"],CustomName:{"text":"DL"}}
execute if score #datalib_extensions.present datalib.meta matches 1.. run execute as @e[type=minecraft:marker,tag=datalib.stage8,limit=1] run say Detected datalib_extensions...
execute if score #datalib_extensions.present datalib.meta matches 1.. run execute as @e[type=minecraft:marker,tag=datalib.stage8,limit=1] run kill @s

# Debug
summon minecraft:marker ~ ~ ~ {Tags:["datalib.stage9"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.stage9,limit=1] run say Done!
execute as @e[type=minecraft:marker,tag=datalib.stage9,limit=1] run kill @s