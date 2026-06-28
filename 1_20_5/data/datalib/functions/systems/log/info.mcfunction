# datalib:systems/log/info
# Logs an INFO-level message. Log level must be >= 3.
# INPUT: data modify storage datalib:engine _log_add_tmp.message set value "..."
execute unless score #dl.log_level dl.log_level matches 3.. run return 0
data modify storage datalib:engine _log_add_tmp.level set value "INFO"
data modify storage datalib:engine _log_add_tmp.color set value "white"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp
