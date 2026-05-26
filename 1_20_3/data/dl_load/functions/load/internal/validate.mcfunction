execute unless data storage datalib:engine global run data modify storage datalib:engine global set value {version:"v5.1.2"}
data modify storage datalib:engine global.version set value "v5.1.2"

execute unless data storage datalib:engine log_display run data modify storage datalib:engine log_display set value []
execute unless score #dl.log_count dl.tmp matches 0.. run scoreboard players set #dl.log_count dl.tmp 0

execute if data storage datalib:engine global{loaded:1b} run data modify storage datalib:input message set value "Already loaded — skipping reload."
execute if data storage datalib:engine global{loaded:1b} run function datalib:systems/log/warn with storage datalib:input {}
execute if data storage datalib:engine global{loaded:1b} run return 0

scoreboard objectives add dl.pre_version dummy
scoreboard players set #dl.mismatch dl.pre_version 0
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.major dl.pre_version matches 5 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.minor dl.pre_version matches 1 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.patch dl.pre_version matches 1 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.ver_set dl.pre_version matches 1 run execute unless score #dl.pre dl.pre_version matches 0 run scoreboard players set #dl.mismatch dl.pre_version 1
execute if score #dl.mismatch dl.pre_version matches 1 run function dl_load:load/internal/version_warn
execute if score #dl.mismatch dl.pre_version matches 1 run return 0

return 1