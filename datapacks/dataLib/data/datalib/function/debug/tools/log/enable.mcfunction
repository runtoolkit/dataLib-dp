# datalib:debug/tools/log/enable
# Turns on test_block console mirroring for systems/log/add calls.
# Requires the test_block to already be placed — run
# /function datalib:systems/log/testblock/place first if you haven't.
# Verify it took effect with: /data get storage datalib:engine security.debug_log
data modify storage datalib:engine security.debug_log set value 1b
