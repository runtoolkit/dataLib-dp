# datalib:systems/log/error
# Logs an ERROR-level message. Log level must be >= 1.
# INPUT: data modify storage datalib:engine _log_add_tmp.message set value "..."
execute unless score #dl.log_level dl.log_level matches 1.. run return 0
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp
