# datalib:systems/log/testblock/pulse [MACRO]
# Writes $(message) into the test_block and powers it, which is what
# actually makes the game write the message to latest.log.
# Input: $(message) — pre-formatted log line, e.g. "[DEBUG] channel X fired"
#
# Read position fresh each call so datalib:systems/log/testblock/place
# never needs to be re-run manually after a debug_log_pos change.
# debug_log_pos already stores flat top-level x/y/z fields, so copying
# it wholesale and adding msg alongside gives pulse_at everything it
# needs via a single 'with storage' call.

data modify storage datalib:tick_work testblock set from storage datalib:engine debug_log_pos
$data modify storage datalib:tick_work testblock.msg set value "$(message)"

function datalib:systems/log/testblock/pulse_at with storage datalib:tick_work testblock

# Unpower one tick later so the block is ready to detect the next
# redstone-style "change" (mode=log logs on each power transition, not
# continuously while powered).
schedule function datalib:systems/log/testblock/unpulse_at 1t replace
