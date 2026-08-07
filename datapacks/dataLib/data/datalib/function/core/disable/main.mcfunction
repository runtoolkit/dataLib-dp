# Gated disable: if the gate system is active (datalib:engine sandbox:1b,
# the default), route through confirmation instead of disabling
# immediately. If gates were turned off via gate/toggle/disable, apply
# directly like before.
execute if data storage datalib:engine {sandbox:1b} run return run function dl_load:gate/request {type:"disable",label:"Disable dataLib",action:"datalib:core/internal/disable/apply",args:{}}

function datalib:core/internal/disable/apply
