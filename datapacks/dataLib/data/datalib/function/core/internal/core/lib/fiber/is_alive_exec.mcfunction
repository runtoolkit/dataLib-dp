# datalib:core/lib/fiber/internal/is_alive_exec [MACRO]
# INPUT: $(id)

data modify storage datalib:output result set value 0b
$execute if data storage datalib:engine fibers.$(id){alive:1b} run data modify storage datalib:output result set value 1b

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/is_alive ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
