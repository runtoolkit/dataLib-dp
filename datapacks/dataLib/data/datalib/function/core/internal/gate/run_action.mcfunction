# datalib:core/internal/gate/run_action
# Runs the function stored in pending_gate.action, passing pending_gate.args
# (if any) as macro arguments. Called with
# 'with storage datalib:engine pending_gate' so $(action) resolves to the
# action string set by gate/request.
#
# INPUT (macro, from pending_gate compound):
#   $(action) -> function id to run, e.g. "datalib:core/internal/cmd/ban_apply"
#   args      -> (not a macro var — read directly from storage below)
#                optional compound of args passed to $(action)

execute if data storage datalib:engine pending_gate.args run return run function datalib:core/internal/gate/run_action_with_args with storage datalib:engine pending_gate

$function $(action)
