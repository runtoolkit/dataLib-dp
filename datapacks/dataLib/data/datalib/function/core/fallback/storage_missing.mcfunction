# datalib:core/fallback/storage_missing
# Called when expected NBT storage data is absent.
data modify storage datalib:engine _log_add_tmp.message set value "[Fallback] storage_missing — required NBT key not found"
data modify storage datalib:engine _log_add_tmp.level set value "WARN"
data modify storage datalib:engine _log_add_tmp.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data modify storage datalib:output fallback set value {triggered:1b,reason:"storage_missing"}
return 0
