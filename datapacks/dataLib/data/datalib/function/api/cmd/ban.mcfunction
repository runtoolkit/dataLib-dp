# Gated ban: if the gate system is active (datalib:engine sandbox:1b, the
# default), route through confirmation. If gates were turned off via
# gate/toggle/disable, apply directly like before.
#
# INPUT : $(player) -> exact player name, $(reason) -> ban reason
$execute if data storage datalib:engine {sandbox:1b} run return run function dl_load:gate/request {type:"ban",label:"Ban $(player) — $(reason)",action:"datalib:core/internal/cmd/ban_apply",args:{player:"$(player)",reason:"$(reason)"}}

$function datalib:core/internal/cmd/ban_apply {player:"$(player)",reason:"$(reason)"}
