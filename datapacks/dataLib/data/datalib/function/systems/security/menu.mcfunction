# datalib:systems/security/menu  [1.21.6 OVERLAY]
# Dialog-based security menu. Replaces tellraw version on 1.21.6+.
# Requires: dl.perm_level >= security.admin_min_level
#
# NOTE: Dialog cannot read storage/score natively — values are injected
# via macro ($) in menu_build.mcfunction.
execute unless function datalib:debug/tools/utils/perm_check run return 0

# Collect dynamic values into datalib:input for macro interpolation
data modify storage datalib:input sandbox set from storage datalib:engine sandbox
data modify storage datalib:input trust_players set from storage datalib:engine security.trust_players
data modify storage datalib:input cmd_min_level set from storage datalib:engine security.cmd_min_level
data modify storage datalib:input sandbox_lvl set from storage datalib:engine security.sandbox_cmd_min_level
data modify storage datalib:input admin_min_level set from storage datalib:engine security.admin_min_level
data modify storage datalib:input admin_override set from storage datalib:engine security.admin_can_override
execute store result storage datalib:input perm_level int 1 run scoreboard players get @s dl.perm_level

function datalib:systems/security/menu_build with storage datalib:input {}
