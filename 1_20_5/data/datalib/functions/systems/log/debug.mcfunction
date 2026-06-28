# datalib:systems/log/debug
# Logs a DEBUG-level message. Log level must be >= 4.
# INPUT: data modify storage datalib:engine _log_add_tmp.message set value "..."
execute unless score #dl.log_level dl.log_level matches 4.. run return 0
data modify storage datalib:engine _log_add_tmp.level set value "DEBUG"
data modify storage datalib:engine _log_add_tmp.color set value "gray"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp
