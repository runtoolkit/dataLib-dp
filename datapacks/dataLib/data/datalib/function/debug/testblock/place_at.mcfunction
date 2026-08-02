# datalib:debug/menu/testblock/place_at [MACRO]
# Input: $(x), $(y), $(z) — from debug_log_pos
$setblock $(x) $(y) $(z) minecraft:test_block[mode=log]{message:"[dataLib] (idle)",mode:"log",powered:0b} replace
