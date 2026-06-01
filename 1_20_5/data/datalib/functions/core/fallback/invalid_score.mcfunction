# datalib:core/fallback/invalid_score
# Called when a required scoreboard value is absent or out of range.
data modify storage datalib:engine _log_add_tmp.message set value "[Fallback] invalid_score — score missing or out of range, using default"
data modify storage datalib:engine _log_add_tmp.level set value "WARN"
data modify storage datalib:engine _log_add_tmp.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:engine {}
data modify storage datalib:output fallback set value {triggered:1b,reason:"invalid_score"}
return 0
