execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0

execute unless entity @s[gamemode=creative,tag=datalib.admin,scores={dl.perm_level=2..}] run return 0

$data remove entity $(target) $(path)
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/data_remove_entity ","color":"aqua"},{"text":"$(target) → $(path)","color":"#555555"}]}
