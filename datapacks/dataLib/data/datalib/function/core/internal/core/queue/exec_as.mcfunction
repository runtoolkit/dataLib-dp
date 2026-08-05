# datalib:core/queue/internal/exec_as
# Runs a queued function as the named player (if online).
# If the player is offline the item is silently dropped — no retry.
#
# Macro input:
#   fn     — function path to call
#   player — player name used in selector

$data modify storage datalib:engine _dispatch.func set value "$(fn)"
$execute as $(player) run function #datalib:internal/dispatch
