# DL Tick Engine v2 — Entry Point
# Driven by #minecraft:tick function tag (guaranteed 1/game-tick, no drift).
#
# All rate/offset/condition/pause logic is inside the channel dispatcher.
# Do NOT add any per-system logic here — register a channel instead.

# Guard: no players online → nothing to process
execute unless entity @a run return 0

# Guard: engine not initialised
# (loaded flag lives under global.loaded — see datalib:runtime/load/loader/load/all which sets
#  `datalib:engine global.loaded`; every other guard in the pack, e.g.
#  core/security/cmd_gate.mcfunction, already checks the correct path)
execute unless data storage datalib:engine global{loaded:1b} run return 0

# Online player count — kept for compatibility
execute store result score #online datalib.onlinePlayers if entity @a

# Guard: globally paused (datalib:runtime/tick/pause / datalib:runtime/tick/resume)
execute if data storage datalib:engine tick{paused:1b} run return 0

execute as @a run function datalib:runtime/tick/dispatch