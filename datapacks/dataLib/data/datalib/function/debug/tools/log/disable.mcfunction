# datalib:debug/tools/log/disable
# Turns off test_block console mirroring for systems/log/add calls.
# Verify it took effect with: /data get storage datalib:engine security.debug_log
data modify storage datalib:engine security.debug_log set value 0b
