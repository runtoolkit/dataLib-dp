# datalib:core/security/type_violation [1.21.5+ overlay]
# Extends base type_violation with test_block server-log entry.
#
# test_block (log mode) was added in Java Edition 25w03a (1.21.5).
# When powered by redstone it writes the message to the server log file,
# providing a persistent audit trail outside the in-game log buffer.
#
# Block placement: y=-62 in dataLib forceloaded chunk (0,0).
# Placed, powered, and removed in the same tick.

# ─── base type_violation (log + tellraw + kick) ──────────────────
data modify storage datalib:engine _log_add_tmp.message set value "[Security] type_violation — command type not in allowlist"
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine _log_add_tmp {}
data remove storage datalib:engine _log_add_tmp.message
data remove storage datalib:engine _log_add_tmp.level
data remove storage datalib:engine _log_add_tmp.color

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Security violation: command type not permitted in sandbox mode.","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"TYPE VIOLATION ","color":"red","bold":true},{"selector":"@s","color":"gold"},{"text":" — blocked (not in allowlist)","color":"red"}]
#execute if entity @s[type=minecraft:player] run kick @s [DL] Security violation — command type not in allowlist

# ─── server log via test_block ───────────────────────────────────
setblock 0 -62 0 minecraft:test_block[mode=log]{message:"[DL SECURITY] type_violation — command type not in allowlist. Run /function datalib:systems/log/show for details."}
setblock 0 -61 0 minecraft:redstone_block
setblock 0 -61 0 minecraft:air
setblock 0 -62 0 minecraft:air
