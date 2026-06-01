# datalib:core/internal/api/interaction/bind_use_do [MACRO] [INTERNAL] [1.20.5]
$data modify storage datalib:engine interaction_binds.use append value {tag:"$(tag)", func:"$(func)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"interaction/bind_use ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
