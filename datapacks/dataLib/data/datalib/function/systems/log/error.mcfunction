# datalib:systems/log/error
# Usage: $function datalib:systems/log/error {message:"[System] Something failed"}
# Level: 1 — always shown unless log is off
$data modify storage datalib:engine _log_add_tmp.message set value "$(message)"
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
execute if score #dl.log_level dl.log_level matches 1.. run function datalib:systems/log/add with storage datalib:engine _log_add_tmp
