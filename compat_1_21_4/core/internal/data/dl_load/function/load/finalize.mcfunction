execute if score #dl.pre dl.pre_version matches 1.. run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"aqua","bold":true},{"text":"ready · dl.pre_version → ","color":"#555555"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"yellow"},{"text":".","color":"#555555"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"yellow"},{"text":".","color":"#555555"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"yellow"},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"#ff8800"}]
execute if score #dl.pre dl.pre_version matches ..0 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"aqua","bold":true},{"text":"ready · dl.pre_version → ","color":"#555555"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"yellow"},{"text":".","color":"#555555"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"yellow"},{"text":".","color":"#555555"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"yellow"}]

data modify storage datalib:engine _log_add_tmp.message set value "✅ All modules initialized. Engine ready."
data modify storage datalib:engine _log_add_tmp.level set value "DL"
data modify storage datalib:engine _log_add_tmp.color set value "green"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp {}
data remove storage datalib:engine _log_add_tmp.message
data remove storage datalib:engine _log_add_tmp.level
data remove storage datalib:engine _log_add_tmp.color