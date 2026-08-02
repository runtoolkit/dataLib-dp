# ======================================================================================
# datalib:api/input/command_block_minecart
# ======================================================================================
#
# TRIGGERED BY: #datalib:api/input/command_block_minecart function tag
#
# PURPOSE:
#   Reads the Command NBT off any command_block_minecart tagged 'datalib_input',
#   dropped into the world via
#   'summon minecraft:command_block_minecart ~ ~ ~ {Tags:["datalib_input"]}'.
#   CAPTURE ONLY — never executes the string itself.
#
# REWRITTEN based on Legends11's reference implementation (TunnelScript-1.20.1:
# tunnelscript_core:internal/minecart_scan + minecart_process + minecart_capture).
# Bugs fixed vs. the previous version:
#
#   BUG 1 — wrong emptiness check. Previous version used
#     'execute unless data entity @s Command run return 0'
#   which only checks whether the Command PATH exists, not whether its VALUE
#   is empty. A minecart with Command:"" (path present, value empty) passed
#   this check and was treated as real input — false positive capture. Fixed
#   by comparing the actual value, matching TunnelScript's
#   'execute unless data storage tunnelscript:minecart {current:""}'.
#
#   BUG 2 — killed the entity instead of clearing it. TunnelScript never
#   kills the minecart: it resets Command back to "" and keeps the entity
#   alive for reuse (this also matches the 'tunnelscript_input' tag used
#   elsewhere by Legends11 for the align/tp helper, which assumes the
#   minecart persists rather than being destroyed each capture). Fixed to
#   clear Command instead of killing @s.
#
#   BUG 3 — 'limit=1,sort=nearest' silently ignored every other tagged
#   minecart in the world. TunnelScript scans ALL tagged minecarts every
#   tick with a plain 'as @e[...]', no limit. Fixed to match.
#
# SECURITY NOTE (unchanged): whoever can summon this entity with a real
# Command value already has raw command-execution ability. This function
# transports that string into the datapack, it does not create the
# privilege — the real permission boundary is who can spawn a marked
# minecart at all.
# ======================================================================================

# Fast exit — nothing tagged, nothing to scan this tick.
execute unless entity @e[type=minecraft:command_block_minecart,tag=datalib_input] run return 0

execute as @e[type=minecraft:command_block_minecart,tag=datalib_input] run function datalib:api/input/private/cbm_process

return 1
