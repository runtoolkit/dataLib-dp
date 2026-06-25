# datalib:api/cb/internal/reset
# Scheduled 2t after exec — cleans up the temporary command block.
# Reads coordinates from transient cb_slot storage so reset targets
# the correct location even if run() was called again in the meantime.

function datalib:core/internal/api/cb/reset_exec with storage datalib:engine _cb_last
