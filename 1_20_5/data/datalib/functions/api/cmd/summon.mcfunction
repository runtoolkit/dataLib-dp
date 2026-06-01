execute unless function datalib:debug/tools/utils/check_all run return 0

execute if data storage datalib:engine {sandbox:1b} run data modify storage datalib:engine _sandbox_cmd set value "summon"
execute if data storage datalib:engine {sandbox:1b} run execute unless function datalib:core/internal/api/cmd/sandbox_gate run return 0
$summon $(entity) $(x) $(y) $(z) $(nbt)
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/summon ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(entity)","color":"aqua"}]}
