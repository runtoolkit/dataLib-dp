# dl_load:gate/toggle/disable
# Disables the gate system (datalib:engine sandbox -> 0b), which means
# dangerous commands stop requiring confirmation. Disabling the gates
# is itself gated — same confirm/cancel/30s flow as ban/kick/disable —
# since turning off the safety net is a dangerous action in its own right.
# Re-enabling (gate/toggle/enable) needs no confirmation.

execute unless entity @s[tag=datalib.admin] run return 0

function dl_load:gate/request {type:"gate_bypass",label:"Disable gate confirmations (dangerous commands will run immediately)",action:"datalib:core/internal/gate/toggle/disable_apply",args:{}}
