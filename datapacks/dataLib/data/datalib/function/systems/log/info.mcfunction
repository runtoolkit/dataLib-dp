# datalib:systems/log/info
# Usage: $function datalib:systems/log/info {message:"[System] Something happened"}
# Level: 3
$data modify storage datalib:engine _log_add_tmp.message set value "$(message)"
data modify storage datalib:engine _log_add_tmp.level set value "INFO"
data modify storage datalib:engine _log_add_tmp.color set value "gray"
execute if score #dl.log_level dl.log_level matches 3.. run function datalib:systems/log/add with storage datalib:engine _log_add_tmp
