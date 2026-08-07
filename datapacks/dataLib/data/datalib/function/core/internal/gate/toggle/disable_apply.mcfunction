# datalib:core/internal/gate/toggle/disable_apply
# Runs after gate confirmation. Actually flips the sandbox flag off.

data modify storage datalib:engine sandbox set value 0b
data modify storage datalib:engine config.sandbox set value 0b
tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Gate confirmations disabled. Dangerous commands will run immediately.","color":"red"}]
