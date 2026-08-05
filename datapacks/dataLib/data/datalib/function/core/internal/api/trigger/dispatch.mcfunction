scoreboard players operation $tc_player dl.tmp = @s dl_action

scoreboard players set @s dl_action 0
scoreboard players enable @s dl_action

execute unless data storage datalib:engine trigger_binds[0] run return 0

data modify storage datalib:engine _tc_binds set from storage datalib:engine trigger_binds

function datalib:core/internal/api/trigger/check_next
data remove storage datalib:engine _tc_binds
data remove storage datalib:engine _tc_current
