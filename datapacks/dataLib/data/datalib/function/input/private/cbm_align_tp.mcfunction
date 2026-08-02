# ======================================================================================
# datalib:input/private/cbm_align_tp  [INTERNAL — call explicitly, not auto-ticked]
# ======================================================================================
#
# Legends11's tested pattern: teleports the executing player to the nearest
# entity tagged 'datalib_input' along their eye-line, avoiding a manual
# rail + redstone_block setup and skipping the "right-click to open" step.
#
# NOT added to #datalib:events/on_tick automatically — this runs 'as @a',
# which is a different cost/behavior profile than the capture functions
# above (it moves players every tick if left running unconditionally).
# Hook this into whatever trigger Legends11 intends (a specific tag,
# a command, an advancement) — not assumed here.
# ======================================================================================

execute as @s at @s anchored eyes align y positioned ^ ^ ^0.0 run tp @e[type=minecraft:command_block_minecart,tag=datalib_input,sort=nearest,limit=1] ~ ~-0.23 ~
