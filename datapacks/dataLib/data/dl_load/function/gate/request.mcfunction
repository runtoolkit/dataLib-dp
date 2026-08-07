# dl_load:gate/request
# Starts a confirm/cancel gated action. Any dangerous action (ban, kick,
# disable, sandbox toggle-off, ...) should route through here instead of
# executing immediately.
#
# INPUT (macro — all four required; pass args:{} for no-arg actions):
#   $(type)   -> gate type, e.g. "disable", "ban", "kick", "gate_bypass"
#   $(label)  -> human-readable text shown in the confirm prompt
#   $(action) -> function to run on confirm, e.g. "datalib:core/disable/main"
#   $(args)   -> compound of macro args passed to $(action) via
#                run_action_with_args, e.g. {player:"Steve",reason:"x"}.
#                Pass {} for actions that take no arguments.
#
# A single global pending_gate slot is used. If a second request comes in
# while one is already pending, the new request is dropped and the
# collision is logged — the original request keeps priority.
#
# KNOWN LIMITATION (not fixed here, pre-existing):
# Callers write to storage before gate/request's own #pending check runs,
# so a second caller can still race the check under concurrent execution.
# This affects all gate types, not just this one.

execute if data storage datalib:engine pending_gate run return run function dl_load:gate/collision

$data modify storage datalib:engine pending_gate.type set value "$(type)"
$data modify storage datalib:engine pending_gate.label set value "$(label)"
$data modify storage datalib:engine pending_gate.action set value "$(action)"
$data modify storage datalib:engine pending_gate.args set value $(args)

tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Confirmation required: ","color":"yellow"},{"nbt":"pending_gate.label","storage":"datalib:engine","color":"white"}," ",{"text":"[Confirm]","color":"green","bold":true,"click_event":{"action":"run_command","command":"/function dl_load:gate/yes"}}," ",{"text":"[Cancel]","color":"red","bold":true,"click_event":{"action":"run_command","command":"/function dl_load:gate/no"}}," ",{"text":"(30s)","color":"gray"}]

schedule function dl_load:gate/timeout 30s
