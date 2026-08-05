# datalib:core/lib/fiber/internal/resume_exec [MACRO]
# INPUT: $(id), $(func)
# Fed from _fib_cur.

# Is the fiber still alive?
$execute unless data storage datalib:engine fibers.$(id){alive:1b} run return 0

# Run via central dispatch
$data modify storage datalib:engine _dispatch.func set value "$(func)"
function #datalib:internal/dispatch

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/resume ","color":"aqua"},{"text":"[run] ","color":"green"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
