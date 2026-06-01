# datalib:core/fallback/not_loaded
# Called when the engine is not initialized.
data modify storage datalib:engine _log_add_tmp.message set value "[Fallback] not_loaded — dataLib not initialized, run /function datalib:load"
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
execute if score #dl.log_level dl.log_level matches 1.. run function datalib:systems/log/add with storage datalib:engine {}
data modify storage datalib:output fallback set value {triggered:1b,reason:"not_loaded"}
return 0
