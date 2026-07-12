$data modify storage datalib:input player set value "$(player)"
$data modify storage datalib:input key set value "$(key)"
function datalib:core/cooldown/check with storage datalib:input {}
# check: result=0b → cooldown active. is_ready returns the inverse.
execute if data storage datalib:output {result:0b} run data modify storage datalib:output result set value 1b
execute if data storage datalib:output {result:1b} run data modify storage datalib:output result set value 0b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/is_ready ","color":"aqua"},{"text":"$(player):$(key) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
