# datalib:systems/log/testblock/place
# Places (or re-places) the mode=log test_block at datalib:engine
# debug_log_pos. Run this once after changing debug_log_pos, or if the
# block is ever broken/removed by world edits.
#
# NOTE: placing/editing a test_block requires operator permission
# (level 2+) — this is a vanilla restriction on the block itself, not a
# limitation added by this pack.

function datalib:systems/log/testblock/place_at with storage datalib:engine debug_log_pos
