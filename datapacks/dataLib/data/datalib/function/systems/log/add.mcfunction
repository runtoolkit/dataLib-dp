# datalib:systems/log/add (internal)
# Called by error/warn/info/debug — do not call directly.
# Appends to the 30-entry ring buffer in datalib:engine log_display.
execute unless data storage datalib:engine log_display run data modify storage datalib:engine log_display set value []

$data modify storage datalib:engine log_display append value {text:"[$(level)] $(message)",color:"$(color)"}

scoreboard players add #dl.log_count dl.tmp 1
execute if score #dl.log_count dl.tmp matches 31.. run data remove storage datalib:engine log_display[0]
execute if score #dl.log_count dl.tmp matches 31.. run scoreboard players remove #dl.log_count dl.tmp 1

# Optional console mirroring via test_block (off by default — enable with
# /function datalib:debug/tools/log/enable). No tellraw, no chat spam:
# this only touches a block's NBT + power state, which is what makes the
# game write the message line into latest.log.
$execute if data storage datalib:engine security{debug_log:1b} run function datalib:systems/log/testblock/pulse {message:"[$(level)] $(message)"}
