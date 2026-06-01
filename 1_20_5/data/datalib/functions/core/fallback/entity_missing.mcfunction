# datalib:core/fallback/entity_missing
# Called when a required entity target was not found.
data modify storage datalib:engine _log_add_tmp.message set value "[Fallback] entity_missing — no valid target found"
data modify storage datalib:engine _log_add_tmp.level set value "WARN"
data modify storage datalib:engine _log_add_tmp.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine {}
data modify storage datalib:output fallback set value {triggered:1b,reason:"entity_missing"}
return 0
