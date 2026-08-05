$scoreboard players operation $ptd_val dl.tmp = @s $(name)

$scoreboard players set @s $(name) 0
$scoreboard players enable @s $(name)

$execute unless data storage datalib:engine perm_triggers.$(name)[0] run return 0

$data modify storage datalib:engine _ptd_binds set from storage datalib:engine perm_triggers.$(name)

function datalib:core/internal/api/perm/trigger/check_bind
data remove storage datalib:engine _ptd_binds
data remove storage datalib:engine _ptd_current
