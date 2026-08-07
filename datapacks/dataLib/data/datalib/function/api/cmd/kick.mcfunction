# Gated kick: if the gate system is active (datalib:engine sandbox:1b, the
# default), route through confirmation. If gates were turned off via
# gate/toggle/disable, apply directly like before.
#
# INPUT : $(player) -> exact player name, $(reason) -> kick reason
$execute if data storage datalib:engine {sandbox:1b} run return run function dl_load:gate/request {type:"kick",label:"Kick $(player) — $(reason)",action:"datalib:core/internal/cmd/kick_apply",args:{player:"$(player)",reason:"$(reason)"}}

$function datalib:core/internal/cmd/kick_apply {player:"$(player)",reason:"$(reason)"}
