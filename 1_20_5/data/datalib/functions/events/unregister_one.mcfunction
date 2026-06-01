$execute unless data storage datalib:engine events.$(event) run return 0

$data modify storage datalib:engine _uro.event set value "$(event)"
$data modify storage datalib:engine _uro.func set value "$(func)"
$data modify storage datalib:engine _uro.src set from storage datalib:engine events.$(event)

$data remove storage datalib:engine events.$(event)

execute if data storage datalib:engine _uro.src[0] run function datalib:core/internal/events/uro_loop

data remove storage datalib:engine _uro
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"event/unregister_one ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]}
