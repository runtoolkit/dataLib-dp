execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[gamemode=creative] run return 0

execute if data storage datalib:engine {sandbox:1b} run data modify storage datalib:engine _sandbox_cmd set value "data_remove_entity"
execute if data storage datalib:engine {sandbox:1b} run execute unless function datalib:core/internal/api/cmd/sandbox_gate run return 0
$data remove entity $(target) $(path)
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/data_remove_entity ","color":"aqua"},{"text":"$(target) → $(path)","color":"#555555"}]}
