# ======================================================================================
# datalib:api/input/private/cbm_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Only reached when cbm_process confirmed Command is non-empty. Runs with
# @s still bound to that minecart.
#
# TOCTOU note: snapshot into datalib:input BEFORE clearing Command, so a
# later tick mutating the entity's NBT cannot change what we already
# captured this tick.
#
# Entity handling matches TunnelScript: Command is cleared back to "" so
# the minecart is reusable and is NOT killed. This also matches the
# 'tunnelscript_input' tag Legends11 uses elsewhere (cbm_align_tp), which
# assumes the tagged minecart persists in the world.
# ======================================================================================

# Snapshot raw command string as-is — no interpretation, no execution.
data modify storage datalib:input cbm.command set from storage datalib:input _cbm.current

data modify storage datalib:input cbm.source_uuid set from entity @s UUID
data modify storage datalib:input cbm.pos set from entity @s Pos

# "raw, unvalidated, unexecuted" — downstream (separate execution pack)
# must run this through datalib:runtime/security/sanitize and
# datalib:debug/menu/tools/utils/input_check before ever treating it as
# runnable, and running it there stays optional, never mandatory.
#
# Separately, if a caller wants cbm.command as a number/bool/tag-safe
# literal (not as a runnable command), use datalib:api/input/validate/check:
#   function datalib:api/input/validate/check with storage <yourpath> {source:"cbm.command", type:"int"}
data modify storage datalib:input cbm.executed set value 0b
execute if data storage datalib:input cbm{executed:0b} run function #datalib:api/input/command_block_minecart

# Clear Command so this same value isn't recaptured next tick — the
# minecart itself is kept alive, not killed.
data modify entity @s Command set value ""

data remove storage datalib:input _cbm
