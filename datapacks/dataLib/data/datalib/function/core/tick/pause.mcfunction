# datalib:core/tick/pause — Suspend all tick channels until datalib:core/tick/resume
data modify storage datalib:engine tick.paused set value 1b
tellraw @s [{"text":"[DL] ","color":"gold"},{"text":"Tick engine paused.","color":"red"}]