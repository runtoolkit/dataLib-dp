# datalib:api/cb/queue_size
# ─────────────────────────────────────────────────────────────────
# Returns the number of pending delayed CB commands.
# Result is stored in score #cb_queue_size dl.tmp.
#
# EXAMPLE:
#   function datalib:api/cb/queue_size
#   # read: scoreboard players get #cb_queue_size dl.tmp
# ─────────────────────────────────────────────────────────────────

execute store result score #cb_queue_size dl.tmp run data get storage datalib:engine cb_queue
