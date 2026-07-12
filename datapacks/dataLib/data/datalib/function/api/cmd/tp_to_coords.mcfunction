execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0

execute unless entity @s[gamemode=creative,tag=datalib.admin,scores={dl.perm_level=2..}] run return 0

$tp $(player) $(x) $(y) $(z)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/tp_to_coords ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(x) $(y) $(z)","color":"green"}]
