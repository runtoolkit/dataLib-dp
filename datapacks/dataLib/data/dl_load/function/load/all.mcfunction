# dl_load:load/all
# Load — entry point called from minecraft:load tag via datalib:load
#
# STAGE DEBUG NOTE (v6.0.1-pre2)
# -------------------------------
# Previously each stage spawned a minecraft:marker entity purely to run
# 'say' (marker context was used because 'say' has no @a[tag=...] filter
# and clickEvent/tellraw rendering was historically unreliable during
# server startup). That pattern summons+kills an entity per stage on
# every single load/reload — unnecessary entity churn for a line of
# debug text. tellraw @a[tag=datalib.debug] needs no executing entity
# and is already gated behind the debug tag, so non-debug players never
# see this spam either.
forceload add -30000000 1600

# Stage 0 — Preparing
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Preparing...","color":"gray"}]

execute unless function dl_load:resolve/validate run return 0

# Stage 1 — Starting
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Starting dataLib...","color":"gray"}]

data modify storage datalib:engine _log_add_tmp.level set value "D.L."
data modify storage datalib:engine _log_add_tmp.message set value "Starting..."
data modify storage datalib:engine _log_add_tmp.color set value "aqua"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp

# RT Origin — Gate 1: watermark doğrulama (artık resolve/validate içinde çağrılıyor, burada tekrar çağırmaya gerek yok)
execute unless data storage datalib:engine {global:{rt_origin_verified:1b}} run return run tellraw @s {"text":"Exit code: 1 — rt_origin verification failed","color":"red"}

# RT Origin — Gate 2: fork check
# If fork_verified field doesn't exist, open the approval gate (1b=original, 0b=fork approved, either passes)
execute unless data storage datalib:engine global.fork_verified run return run function dl_load:load/fork

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Fork gate passed...","color":"gray"}]

# Stage 2 — scoreboards (moved to loader/ — see dl_load:loader/scoreboards)
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loading scoreboards...","color":"gray"}]
function dl_load:loader/scoreboards

# Stage 3 — storages (moved to loader/ — see dl_load:loader/storages)
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loading storages...","color":"gray"}]
function dl_load:loader/storages

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Loading other systems...","color":"gray"}]

function dl_load:load/other

data modify storage datalib:engine global.loaded set value 1b

function dl_load:core/internal/load/version_set

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Setting version...","color":"gray"}]

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

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Finalizing...","color":"gray"}]

function dl_load:core/internal/load/finalize

# Detect datalib_extensions
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Finding datalib_extensions...","color":"gray"}]

execute if score #datalib_extensions.present datalib.meta matches 1.. run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Detected datalib_extensions...","color":"gray"}]

# Debug
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Done!","color":"green"}]
