# dl_load:gate/toggle/enable
# Re-enables the gate system (datalib:engine sandbox -> 1b). No
# confirmation needed — turning the safety net back on is always safe.

execute unless entity @s[tag=datalib.admin] run return 0

data modify storage datalib:engine sandbox set value 1b
data modify storage datalib:engine config.sandbox set value 1b
tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Gate confirmations re-enabled.","color":"green"}]
