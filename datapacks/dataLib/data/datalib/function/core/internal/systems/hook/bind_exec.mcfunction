# datalib:systems/hook/internal/bind_exec [MACRO]
# INPUT: $(event) - required
# datalib:input.func OR datalib:input.cmd - one must exist
#
# Two-step: append a base compound with just event, then set func or cmd from storage.
# This avoids requiring both $(func) and $(cmd) to be present simultaneously.

$data modify storage datalib:engine hook_binds append value {event:"$(event)"}
execute if data storage datalib:input func run data modify storage datalib:engine hook_binds[-1].func set from storage datalib:input func
execute unless data storage datalib:input func run data modify storage datalib:engine hook_binds[-1].cmd set from storage datalib:input cmd

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"hook/bind ","color":"aqua"},{"text":"$(event)","color":"yellow"}]
