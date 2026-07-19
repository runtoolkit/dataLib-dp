# datalib:systems/hook/unbind_all
# Clears all hook binds.

data modify storage datalib:engine hook_binds set value []

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"hook/unbind_all ","color":"aqua"},{"text":"⚠ all hook binds cleared","color":"yellow"}]
