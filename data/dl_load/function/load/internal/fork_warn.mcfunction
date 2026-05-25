# dl_load:load/internal/fork_warn
# Called when rt_origin_verified is absent at load time.
# Indicates _rt_origin.mcfunction was removed or pack is a modified fork.
# Load continues — this is a warning, not a hard block.

playsound datalib:ui.warn master @a ~ ~ ~ 0.5 0.9

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"Modified fork detected.","color":"yellow"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ FORK ","color":"yellow","bold":true},{"text":"rt_origin_verified missing — _rt_origin.mcfunction removed or pack is modified.","color":"yellow"}]

data modify storage datalib:input message set value "[Load] fork_warn — rt_origin_verified not set, possible modified fork"
function datalib:systems/log/warn with storage datalib:input {}
data remove storage datalib:input message
