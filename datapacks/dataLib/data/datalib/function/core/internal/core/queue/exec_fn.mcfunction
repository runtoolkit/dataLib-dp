# datalib:core/queue/internal/exec_fn
# Runs a queued function in server (non-entity) context.
# Called with storage datalib:engine _wq_job as macro source.
#
# Macro input:
#   fn — function path to call

$data modify storage datalib:engine _dispatch.func set value "$(fn)"
function #datalib:internal/dispatch
