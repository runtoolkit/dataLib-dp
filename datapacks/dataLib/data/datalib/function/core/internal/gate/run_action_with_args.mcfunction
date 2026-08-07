# datalib:core/internal/gate/run_action_with_args
# Same as run_action but the target function also needs macro args from
# pending_gate.args (e.g. ban/kick need player+reason). Runs $(action)
# with storage pointed at pending_gate.args so its own $(player)/$(reason)
# macros resolve.
#
# INPUT (macro, from pending_gate compound):
#   $(action) -> function id to run

$function $(action) with storage datalib:engine pending_gate.args
