# dl_load:gate/yes
# Confirms the pending gated action and runs it.
# Only players with datalib.admin may call this directly — vanilla target
# selectors cannot query real op/permission level, so the tag is the trust
# boundary here (same one load/other.mcfunction already uses for
# dl_menu/dl_run/dl_action).

execute unless entity @s[tag=datalib.admin] run return 0
execute unless data storage datalib:engine pending_gate run return 0

schedule clear dl_load:gate/timeout

function datalib:core/internal/gate/run_action with storage datalib:engine pending_gate
data remove storage datalib:engine pending_gate
