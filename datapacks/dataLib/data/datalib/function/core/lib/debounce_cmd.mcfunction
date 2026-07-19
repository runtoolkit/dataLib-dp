$execute if data storage datalib:engine schedules.$(key) run return 0

function datalib:core/lib/schedule_cmd with storage datalib:input {}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/debounce_cmd ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
