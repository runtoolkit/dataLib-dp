execute unless data storage datalib:engine trigger_binds run data modify storage datalib:engine trigger_binds set value []

$data modify storage datalib:engine trigger_binds append value {value:$(value), func:"$(func)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"trigger/bind ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(value)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
