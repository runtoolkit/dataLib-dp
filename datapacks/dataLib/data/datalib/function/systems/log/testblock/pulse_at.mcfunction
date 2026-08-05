# datalib:systems/log/testblock/pulse_at [MACRO]
# Input: $(x), $(y), $(z), $(msg) — from the testblock compound built
# in pulse.mcfunction (debug_log_pos fields + msg alongside them).
# 'replace' keeps it a fresh block-entity each time so the message
# always actually updates (partial NBT merges on test_block can be
# unreliable across versions; a full replace is the safe, portable way).
$setblock $(x) $(y) $(z) minecraft:test_block[mode=log]{message:"$(msg)",mode:"log",powered:1b} replace
