# DL Tick — Channel Loader [MACRO]
# Copies channels[i] into work storage, skips if disabled.
# Input: $(i) — channel index

$data modify storage datalib:tick_work channel set from storage datalib:engine tick.channels[$(i)]
execute unless data storage datalib:tick_work channel{enabled:1b} run return 0
function datalib:core/tick/dispatch/rate_check with storage datalib:tick_work channel