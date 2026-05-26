# dl_load:load/internal/finalize
# Son adım — başarı mesajı ve debug bilgisi.

# Debug: version bilgisi
execute if score #dl.pre dl.pre_version matches 1.. run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"ready · ","color":"#555555"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua"},{"text":".","color":"#555555"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua"},{"text":".","color":"#555555"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua"},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"#ff8800"}]
execute if score #dl.pre dl.pre_version matches ..0 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"ready · ","color":"#555555"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua"},{"text":".","color":"#555555"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua"},{"text":".","color":"#555555"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua"}]

# Fork uyarısı — debug tier (summary)
execute if data storage datalib:engine {fork_warn:1b} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"Modified fork — _rt_origin not verified. ","color":"yellow"},{"text":"[details above]","color":"#555555","italic":true}]

# Fork uyarısı — admin tier (compact reminder)
execute if data storage datalib:engine {fork_warn:1b} run tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"Loaded with fork warning active.","color":"yellow"}]

# Başarı mesajı — tüm oyunculara
execute if score #dl.pre dl.pre_version matches 1.. run tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"v","color":"aqua"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"#ff8800","bold":true},{"text":" loaded.","color":"green"}]
execute if score #dl.pre dl.pre_version matches ..0 run tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"v","color":"aqua"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":".","color":"aqua"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"aqua","bold":true},{"text":" loaded.","color":"green"}]

playsound datalib:load.success master @a ~ ~ ~ 0.6 1.2

data modify storage datalib:input message set value "[Load] finalize — engine ready"
function datalib:systems/log/add with storage datalib:input {}
data remove storage datalib:input message
