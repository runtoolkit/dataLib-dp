tellraw @s {"text":"[dataLib] This datapack is ARCHIVED and no longer maintained. It will NOT load. To load it anyway, manually run: function #load:_private/load","color":"red"}

execute unless function datalib:debug/tools/utils/load_check run return 0
execute unless function datalib:debug/tools/utils/perm_check run return 0
execute unless function datalib:debug/tools/utils/input_check run return 0
