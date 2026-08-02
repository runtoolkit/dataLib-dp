# datalib:core/lib/batch/internal/cancel_exec [MACRO]
# INPUT: $(id)

$execute unless data storage datalib:engine batches.$(id) run return 0
$data remove storage datalib:engine batches.$(id)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/batch/cancel ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" — cancelled","color":"#FF5555"}]
