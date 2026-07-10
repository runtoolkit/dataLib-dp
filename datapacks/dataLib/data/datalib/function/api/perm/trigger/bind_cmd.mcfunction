$scoreboard objectives add $(name) trigger

$execute unless data storage datalib:engine perm_triggers.$(name) run data modify storage datalib:engine perm_triggers.$(name) set value []
$data modify storage datalib:engine perm_triggers.$(name) append value {value:$(value), cmd:"$(cmd)", perm:"$(perm)"}

execute unless data storage datalib:engine perm_trigger_names run data modify storage datalib:engine perm_trigger_names set value []
$execute unless data storage datalib:engine perm_trigger_names[{name:"$(name)"}] run data modify storage datalib:engine perm_trigger_names append value {name:"$(name)"}

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm/trigger/bind_cmd ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(name)","color":"white"},{"text":":","color":"#555555"},{"text":"$(value)","color":"yellow"},{"text":" → ","color":"#555555"},{"text":"$(cmd)","color":"aqua"},{"text":" [","color":"#555555"},{"text":"$(perm)","color":"green"},{"text":"]","color":"#555555"}]
