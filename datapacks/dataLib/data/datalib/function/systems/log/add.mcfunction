# datalib:systems/log/add (internal)
# Called by error/warn/info/debug — do not call directly.
# Appends to the 30-entry ring buffer in datalib:engine log_display.
execute unless data storage datalib:engine log_display run data modify storage datalib:engine log_display set value []

$data modify storage datalib:engine log_display append value {text:"[$(level)] $(message)",color:"$(color)"}

scoreboard players add #dl.log_count dl.tmp 1
execute if score #dl.log_count dl.tmp matches 31.. run data remove storage datalib:engine log_display[0]
execute if score #dl.log_count dl.tmp matches 31.. run scoreboard players remove #dl.log_count dl.tmp 1
