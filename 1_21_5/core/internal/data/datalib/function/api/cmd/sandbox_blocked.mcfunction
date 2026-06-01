# datalib:core/internal/api/cmd/sandbox_blocked [1.21.5+ overlay]
# Extends the base sandbox_blocked with a test_block server log entry.
#
# NOTE (v5.1.2): The primary sandbox enforcement path now goes through
# datalib:core/internal/api/cmd/sandbox_gate → datalib:core/security/type_violation.
# This function is retained for direct callers and backwards compatibility.
# The type_violation overlay (1_21_5) handles test_block logging for the
# new gate path.
#
# test_block (log mode) was added in Java Edition 25w03a (1.21.5).
# When powered by redstone it writes its message to the server log file,
# providing a persistent audit trail outside the in-game log buffer.
#
# Block placement uses y=-62 in the dataLib forceloaded chunk (0,0).
# The block is placed, powered, and immediately removed in the same tick.
function datalib:core/internal/api/cmd/sandbox_blocked_macro with storage datalib:engine {}

# ─── server log via test_block ───────────────────────────────────
setblock 0 -62 0 minecraft:test_block[mode=log]{message:"[DL SANDBOX] Dangerous command blocked. Run /function datalib:systems/log/show for details."}
setblock 0 -61 0 minecraft:redstone_block
setblock 0 -61 0 minecraft:air
setblock 0 -62 0 minecraft:air
