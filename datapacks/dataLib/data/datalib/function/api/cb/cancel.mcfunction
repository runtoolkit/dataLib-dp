# datalib:api/cb/cancel
# ─────────────────────────────────────────────────────────────────
# Clears all pending delayed CB commands from the queue.
#
# No input required. Clears the entire queue.
#
# SECURITY: caller must hold dl.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
#   function datalib:api/cb/cancel
# ─────────────────────────────────────────────────────────────────

execute unless function datalib:core/security/cmd_gate run return 0

data remove storage datalib:engine cb_queue
data modify storage datalib:engine cb_queue set value []
