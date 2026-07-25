#> This is the main function, that will run once per tick

# Config-level pause guard (separate from the storage-level pause in core/tick.mcfunction)
execute if score #runtoolkit.packs.datalib.config.tick.pause datalib.meta matches 1 run return 0

# Ensure tick config defaults exist (idempotent, only fills missing keys)
execute unless score #runtoolkit.packs.datalib.config.tick.rate datalib.meta matches 1.. run function datalib:config/tick_cfg

# If tick.rate is not >= 1, skip the real tick work and run the no-op once instead
execute if score #runtoolkit.packs.datalib.config.tick.rate datalib.meta matches ..0 run function datalib.main:empty
execute if score #runtoolkit.packs.datalib.config.tick.rate datalib.meta matches ..0 run return 0

execute if score #runtoolkit.packs.datalib.config.tick.rate datalib.meta matches 1.. at @s run function datalib:core/tick
execute if score #runtoolkit.packs.datalib.config.tick.rate datalib.meta matches 1.. run function #datalib:loop
